import 'package:robocup/models/ModelProvider.dart';
import 'package:collection/collection.dart';

(double, double) getMaxAndTotalScore(TotalScore totalScore, LineTrackingMap map){
  double maxLineTrackingScore = 0;
  double maxEvacuationZoneMultiplier = 0;
  double maxScore = 0;

  double lineTrackingScore = 0;
  double evacuationZoneMultiplier = 0;
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
      int obstacles = checkPoint.obstacles! * 15;
      int intersections = checkPoint.intersections! * 10;
      int ramps = checkPoint.ramps! * 10;
      int speedBumps = checkPoint.speedBumps * 5;
      int seesaws = checkPoint.seesaws! * 15;

      maxLineTrackingScore += tiles + gaps + obstacles + intersections + ramps + speedBumps + seesaws;
    }
  }

  maxScore = (maxLineTrackingScore + 60) * maxEvacuationZoneMultiplier;

  for (var checkPointScore in totalScore.checkPointsScores){
    final checkPoint = map.checkpoints!.firstWhereOrNull((element) => element.number == checkPointScore.checkPointNumber);

    if (checkPoint != null){
      if (checkPoint.tiles == 0){
        int livingVictimsCollected = checkPointScore.livingVictimsCollected;
        int deadVictimsCollected = checkPointScore.deadVictimsCollected;
        int zoneTotalLOP = checkPointScore.totalLOP;

        double victimPoints = (livingVictimsCollected + deadVictimsCollected) * 1.4;
        double deduction = zoneTotalLOP * 0.05;

        evacuationZoneMultiplier = victimPoints - deduction;
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
        int obstacles = checkPointScore.obstaclesPassed * 15;
        int intersections = checkPointScore.intersectionsPassed * 10;
        int ramps = checkPointScore.rampsPassed * 10;
        int speedBumps = checkPointScore.speedBumpsPassed * 5;
        int seesaws = checkPointScore.seesawsPassed * 15;

        lineTrackingScore += tiles + gaps + obstacles + intersections + ramps + speedBumps + seesaws;
        totalLOP += checkPointScore.totalLOP;
      }
    }
  }

  achievedScore = (lineTrackingScore + (60 - 5 * (totalLOP))) * evacuationZoneMultiplier;

  return (maxScore.roundToDouble(), achievedScore.roundToDouble());

}