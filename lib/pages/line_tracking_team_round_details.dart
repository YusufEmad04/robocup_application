import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:robocup/functtions/functions.dart';
import 'package:robocup/models/ModelProvider.dart';
import '../repositories/line_tracking_repository.dart';

class LineTrackingTeamRoundDetails extends StatelessWidget {
  final String teamID;
  final String roundID;
  final String category;
  const LineTrackingTeamRoundDetails({required this.teamID, required this.roundID, required this.category, super.key});

  Future<(TotalScore, LineTrackingMap)?> getRoundDetails(String teamID, String roundID, String category, LineTrackingRepository lineTrackingRepository) async {
    LineTrackingTeam? team;
    LineTrackingRound? round;
    LineTrackingMap? map;

    // get team
    team = lineTrackingRepository.lineTrackingTeams.firstWhereOrNull((element) => element.id == teamID);
    team ??= await lineTrackingRepository.getLineTrackingTeam(teamID, withRounds: true);

    if (team == null){
      return null;
    }

    // get round
    if (team.lineTrackingRounds == null){
      team = await lineTrackingRepository.getLineTrackingTeam(teamID, withRounds: true);
      if (team == null){
        return null;
      }
      round = team.lineTrackingRounds!.firstWhereOrNull((element) => element.id == roundID);
    } else {
      round = team.lineTrackingRounds!.firstWhereOrNull((element) => element.id == roundID);
    }

    if (round == null){
      return null;
    }

    // get map
    map = lineTrackingRepository.lineTrackingMaps.firstWhereOrNull((element) => element.id == round!.lineTrackingRoundLineTrackingMapId);
    map ??= await lineTrackingRepository.getLineTrackingMap(round.lineTrackingRoundLineTrackingMapId);

    if (map == null){
      return null;
    }

    return (round.scoreDetails!, map);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Round Details'),
      ),
      body: FutureBuilder(
        future: getRoundDetails(teamID, roundID, category, context.read<LineTrackingRepository>()),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError){
            return const Center(
              child: Text("Error loading round details"),
            );
          } else if (snapshot.hasData){

            final (totalScore, map) = snapshot.data as (TotalScore, LineTrackingMap);
            final (max, total) = getMaxAndTotalScore(totalScore, map);

            final widgets = [];

            // sorted checkPoints by number
            map.checkpoints!.sort((a, b) => a.number.compareTo(b.number));

            for (var checkPoint in map.checkpoints!){

              final checkPointScore = totalScore.checkPointsScores.firstWhereOrNull((element) => element.checkPointNumber == checkPoint.number);
              if (checkPointScore == null) {
                widgets.add(Text("Check Point ${checkPoint.number}"));
                widgets.add(Text("Number of Tiles: ${checkPoint.tiles}"));
                widgets.add(const Text("Total LOP: 0"));
                widgets.add(const Text("Tiles Score: 0"));
                widgets.add(const Divider());
                continue;
              }

              final checkPointTotalLOP = checkPointScore.totalLOP;

              if (checkPoint.tiles == 0) {
                continue;
              }

              int tilesTotalScore = checkPointScore.tilesPassed;
              if (checkPointTotalLOP == 0) {
                tilesTotalScore *= 5;
              } else if (checkPointTotalLOP == 1) {
                tilesTotalScore *= 3;
              } else if (checkPointTotalLOP == 2) {
                tilesTotalScore *= 1;
              } else {
                tilesTotalScore = 0;
              }

              widgets.add(Text("Check Point ${checkPoint.number}", style: Theme.of(context).textTheme.headlineSmall,));
              widgets.add(Text("Number of Tiles: ${checkPoint.tiles}"));
              widgets.add(Text("Total LOP: $checkPointTotalLOP"));
              // widgets.add(Text("Tiles Score: ${checkPointScore.tilesPassed} * ${checkPointTotalLOP == 0 ? 5 : checkPointTotalLOP == 1 ? 3 : checkPointTotalLOP == 2 ? 1 : 0} = $tilesTotalScore"));
              widgets.add(
                  Text("Tiles Score: ${checkPointScore.tilesPassed} * ${checkPointTotalLOP == 0 ? 5 : checkPointTotalLOP == 1 ? 3 : checkPointTotalLOP == 2 ? 1 : 0} = $tilesTotalScore", textAlign: TextAlign.center,)
              );
              widgets.add(
                  checkPoint.gaps! > 0 ?
                  Text("Gaps Score: (gaps passed: ${checkPointScore.gapsPassed} / ${checkPoint.gaps!})      ${checkPointScore.gapsPassed} * 10 = ${checkPointScore.gapsPassed * 10}", textAlign: TextAlign.center,)
                      : const SizedBox.shrink()
              );

              widgets.add(
                  checkPoint.obstacles! > 0 ? Text("Obstacles Score: (obstacles passed: ${checkPointScore.obstaclesPassed} / ${checkPoint.obstacles!})      ${checkPointScore.obstaclesPassed} * 15 = ${checkPointScore.obstaclesPassed * 15}", textAlign: TextAlign.center,)
                      : const SizedBox.shrink()
              );
              widgets.add(
                  checkPoint.intersections! > 0 ? Text("Intersections Score: (intersections passed: ${checkPointScore.intersectionsPassed} / ${checkPoint.intersections!})      ${checkPointScore.intersectionsPassed} * 10 = ${checkPointScore.intersectionsPassed * 10}", textAlign: TextAlign.center,)
                      : const SizedBox.shrink()
              );
              widgets.add(
                  checkPoint.ramps! > 0 ? Text("Ramps Score: (ramps passed: ${checkPointScore.rampsPassed} / ${checkPoint.ramps!})      ${checkPointScore.rampsPassed} * 10 = ${checkPointScore.rampsPassed * 10}", textAlign: TextAlign.center,)
                      : const SizedBox.shrink()
              );
              widgets.add(
                  checkPoint.speedBumps > 0 ? Text("Speed Bumps Score: (speed bumps passed: ${checkPointScore.speedBumpsPassed} / ${checkPoint.speedBumps})      ${checkPointScore.speedBumpsPassed} * 5 = ${checkPointScore.speedBumpsPassed * 5}", textAlign: TextAlign.center,)
                      : const SizedBox.shrink()
              );
              widgets.add(
                  checkPoint.seesaws! > 0 ? Text("Seesaws Score: (seesaws passed: ${checkPointScore.seesawsPassed} / ${checkPoint.seesaws!})      ${checkPointScore.seesawsPassed} * 15 = ${checkPointScore.seesawsPassed * 15}", textAlign: TextAlign.center,)
                      : const SizedBox.shrink()
              );
              widgets.add(const Divider());

            }

            final evacuationZone = map.checkpoints!.firstWhereOrNull((element) => element.tiles == 0);
            if (evacuationZone != null){
              final evacuationZoneScore = totalScore.checkPointsScores.firstWhereOrNull((element) => element.checkPointNumber == evacuationZone.number);
              if (evacuationZoneScore != null) {
                widgets.add(Text("Evacuation Zone", style: Theme.of(context).textTheme.displaySmall,));
                widgets.add(Text("Total LOP: ${evacuationZoneScore.totalLOP}", textAlign: TextAlign.center,));
                widgets.add(Text("Living Victims Collected: ${evacuationZoneScore.livingVictimsCollected} / ${evacuationZone.livingVictims}", textAlign: TextAlign.center,));
                widgets.add(Text("Dead Victims Collected: ${evacuationZoneScore.deadVictimsCollected} / ${evacuationZone.deadVictims}", textAlign: TextAlign.center,));
                widgets.add(const Divider());
              }
            }

            widgets.add(Text("Total Score: $total", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall,));
            widgets.add(Text("Max Score: $max", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall,));
            widgets.add(const Divider());

            return SingleChildScrollView(
              child: Column(
                  children: [
                    const Divider(),
                    for (var i in widgets) i is! SizedBox? Padding(padding: const EdgeInsets.all(8.0), child: i) : i,
                  ]
              ),
            );

          } else {
            return const Center(
              child: Text("Error loading round details"),
            );
          }
        },
      ),
    );
  }
}
