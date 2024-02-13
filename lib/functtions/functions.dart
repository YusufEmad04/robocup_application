import 'package:flutter/material.dart';
import 'package:robocup/models/ModelProvider.dart';
import 'package:collection/collection.dart';

(double, double) getMaxAndTotalScore(TotalScore totalScore, LineTrackingMap map){
  double maxLineTrackingScore = 0;
  double maxEvacuationZoneMultiplier = 0;
  double maxScore = 0;

  double lineTrackingScore = 0;
  double evacuationZoneMultiplier = 1;
  double totalLOP = 0;
  double achievedScore = 0;

  for (var checkPoint in map.checkpoints!) {

    if (checkPoint.tiles == 0){

      // evacuation zone
      int livingVictims = checkPoint.livingVictims!;
      int deadVictims = checkPoint.deadVictims!;
      maxEvacuationZoneMultiplier = (livingVictims + deadVictims) * 1.4;
    } else {
      int tiles = checkPoint.tiles * 5;
      int gaps = checkPoint.gaps! * 10;
      int obstacles = checkPoint.obstacles! * 20;
      int intersections = checkPoint.intersections! * 10;
      int ramps = checkPoint.ramps! * 10;
      int speedBumps = checkPoint.speedBumps * 10;
      int seesaws = checkPoint.seesaws! * 20;

      maxLineTrackingScore += tiles + gaps + obstacles + intersections + ramps + speedBumps + seesaws;
    }
  }

  maxScore = (maxLineTrackingScore + 60 + 5) * maxEvacuationZoneMultiplier;

  for (var checkPointScore in totalScore.checkPointsScores){
    final checkPoint = map.checkpoints!.firstWhereOrNull((element) => element.number == checkPointScore.checkPointNumber);

    if (checkPoint != null){
      print("${checkPoint.tiles}------------");
      print("${checkPointScore.tilesPassed}------------");
      print("${checkPointScore.totalLOP}------------");
      print(checkPointScore);
      print("---");
      if (checkPoint.tiles == 0){
        int livingVictimsCollected = checkPointScore.livingVictimsCollected;
        int deadVictimsCollected = checkPointScore.deadVictimsCollected;
        int zoneTotalLOP = checkPointScore.totalLOP;

        double victimPoints = (livingVictimsCollected + deadVictimsCollected) * 1.4;
        double deduction = zoneTotalLOP * 0.05;

        if (victimPoints - deduction <= 0) {
          evacuationZoneMultiplier = 1;
        } else {
          evacuationZoneMultiplier = victimPoints - deduction;
        }
        totalLOP += zoneTotalLOP;

      } else {

        int tiles = 0;
        if (checkPointScore.totalLOP == 0){
          tiles = checkPointScore.tilesPassed * 5;
        } else if (checkPointScore.totalLOP == 1){
          tiles = checkPointScore.tilesPassed * 3;
        } else if (checkPointScore.totalLOP == 2){
          tiles = checkPointScore.tilesPassed;
        }

        int gaps = checkPointScore.gapsPassed * 10;
        int obstacles = checkPointScore.obstaclesPassed * 20;
        int intersections = checkPointScore.intersectionsPassed * 10;
        int ramps = checkPointScore.rampsPassed * 10;
        int speedBumps = checkPointScore.speedBumpsPassed * 10;
        int seesaws = checkPointScore.seesawsPassed * 20;

        lineTrackingScore += (tiles + gaps + obstacles + intersections + ramps + speedBumps + seesaws);
        print(tiles);
        print(lineTrackingScore - tiles);
        totalLOP += checkPointScore.totalLOP;
      }
    }
  }

  // get max checkpoint number (the last tile for exit)
  int maxCheckPointNumber = 0;
  for (var checkPoint in map.checkpoints!){
    if (checkPoint.number > maxCheckPointNumber){
      maxCheckPointNumber = checkPoint.number;
    }
  }

  var checkPoint = totalScore.checkPointsScores.firstWhereOrNull((element) => element.checkPointNumber == maxCheckPointNumber);

  double exitBonus = 0;

  if(checkPoint != null){
    if(checkPoint.tilesPassed != 0) {
      exitBonus =  (60 - 5 * (totalLOP));
    }
  }

  achievedScore = (lineTrackingScore + exitBonus + 5) * evacuationZoneMultiplier;
  print(evacuationZoneMultiplier);
  print("achieved: ${achievedScore}");

  return (maxScore.roundToDouble(), achievedScore.roundToDouble());

}

Future<bool> showDialogFunction(context, String title, String text, String left, String right) async {

  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          text,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text(left),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text(right),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
  if (result != null) {
    return result;
  } else {
    return false;
  }
}