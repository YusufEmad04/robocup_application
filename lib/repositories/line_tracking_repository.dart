import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:robocup/models/LineTrackingMap.dart';

import '../models/LineTrackingRound.dart';
import '../models/LineTrackingTeam.dart';

class LineTrackingRepository {
  final lineTrackingTeams = <LineTrackingTeam>[];
  final lineTrackingMaps = <LineTrackingRound>[];

  //TODO use get instead of load to reduce the number of requests

  Future<void> loadLineTrackingTeams() async {
    final lineTrackingTeamsRequest = ModelQueries.list(LineTrackingTeam.classType);
    final lineTrackingTeamsResponse = await Amplify.API.query(request: lineTrackingTeamsRequest).response;

    final lineTrackingTeamsItems = lineTrackingTeamsResponse.data?.items;

    if (lineTrackingTeamsItems != null) {
      lineTrackingTeams.clear();
      for (var item in lineTrackingTeamsItems) {
        lineTrackingTeams.add(item!);
      }
    }
  }

  Future<void> loadLineTrackingTeamRounds(String id) async {

    // if lineTrackingRounds remains null, then there should be an error

    final team = lineTrackingTeams.firstWhere((element) => element.id == id);

    final lineTrackingRoundRequest = ModelQueries.list(LineTrackingRound.classType, where: LineTrackingRound.LINETRACKINGTEAMID.eq(id));
    final lineTrackingRoundResponse = await Amplify.API.query(request: lineTrackingRoundRequest).response;

    final lineTrackingRoundItems = lineTrackingRoundResponse.data?.items;

    if (lineTrackingRoundItems != null) {
      final lineTrackingRounds = <LineTrackingRound>[];

      for (var item in lineTrackingRoundItems) {
        lineTrackingRounds.add(item!);
      }

      final updatedTeam = team.copyWith(lineTrackingRounds: lineTrackingRounds);
      lineTrackingTeams.removeWhere((element) => element.id == id);
      lineTrackingTeams.add(updatedTeam);

    }
  }

  Future<void> loadLineTrackingMaps() async {
    // TODO implement nested request to load also the checkpoints
  }

  Future<List<LineTrackingTeam>?> getLineTrackingTeams() async {
    //TODO implement get line tracking teams method from repository
    // will be used instead of loadLineTrackingTeams
  }

  Future<LineTrackingTeam?> getLineTrackingTeam(String id) async {
    final team = lineTrackingTeams.firstWhere((element) => element.id == id);
    if (team.lineTrackingRounds == null) {
      // TODO send a request to get the team
    } else {
      return team;
    }
  }

  Future<LineTrackingMap?> getLineTrackingMap(String id) async {
    // TODO send nested request to get the checkpoints
  }

}