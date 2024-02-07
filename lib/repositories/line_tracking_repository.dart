import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Category;
import 'package:robocup/models/LineTrackingMap.dart';
import 'package:collection/collection.dart';
import 'package:robocup/models/ModelProvider.dart';
import '../models/LineTrackingRound.dart';
import '../models/LineTrackingTeam.dart';
import 'package:robocup/models/Category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LineTrackingRepository {
  final lineTrackingTeams = <LineTrackingTeam>[];
  final lineTrackingMaps = <LineTrackingMap>[];

  LineTrackingRepository() {
    uploadLocalRounds();
  }

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

  Future<LineTrackingTeam?> loadLineTrackingTeamRounds(String id) async {

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
      return updatedTeam;
    } else {
      return null;
    }
  }

  Future<List<LineTrackingMap>?> getLineTrackingMaps() async {
    print("loadLineTrackingMaps");
    // TODO implement nested request to load also the checkpoints
    const graphQLDocument = r'''query listLineTrackingMaps($filter: ModelLineTrackingMapFilterInput, $limit: Int, $nextToken: String) {
    listLineTrackingMaps(filter: $filter, limit: $limit, nextToken: $nextToken) {
        items {
            id
            day
            checkpoints {
            items {
                id
                linetrackingmapID
                tiles
                gaps
                obstacles
                intersections
                ramps
                speedBumps
                seesaws
                livingVictims
                deadVictims
                number
            }
           }
        }
        }
    }
    
    ''';

    final request = GraphQLRequest<PaginatedResult<LineTrackingMap>>(
      document: graphQLDocument,
      decodePath: 'listLineTrackingMaps',
      modelType: const PaginatedModelType(LineTrackingMap.classType),
    );

    final response = await Amplify.API.query(request: request).response;

    final lineTrackingMapsItems = response.data?.items;

    if (lineTrackingMapsItems != null) {
      lineTrackingMaps.clear();
      print("length: ${lineTrackingMapsItems.length}");
      for (var item in lineTrackingMapsItems) {
        print(item);
        lineTrackingMaps.add(item!);
      }
      lineTrackingMaps.sort((a, b) => a.day.compareTo(b.day));
      return lineTrackingMaps;
    } else {
      print("error");
      print("error: ${response.errors}");
      return null;
    }

  }

  Future<List<LineTrackingTeam>?> getLineTrackingTeams(String category) async {
    //TODO implement get line tracking teams method from repository
    // will be used instead of loadLineTrackingTeams
    // TODO add category to the query

    final lineTrackingTeamsRequest = ModelQueries.list(
        LineTrackingTeam.classType,
        where: LineTrackingTeam.CATEGORY.eq(category == "primary" ? Category.PRIMARY : Category.OPEN),
    );
    final lineTrackingTeamsResponse = await Amplify.API.query(request: lineTrackingTeamsRequest).response;

    final lineTrackingTeamsItems = lineTrackingTeamsResponse.data?.items;

    if (lineTrackingTeamsItems != null) {
      lineTrackingTeams.clear();
      for (var item in lineTrackingTeamsItems) {
        lineTrackingTeams.add(item!);
      }
      return lineTrackingTeams;
    } else {
      return null;
    }

  }

  Future<LineTrackingTeam?> getLineTrackingTeam(String id, {withRounds = false}) async {
    final team = lineTrackingTeams.firstWhereOrNull((element) => element.id == id);

    if (team == null){
      final lineTrackingTeamRequest = ModelQueries.list(LineTrackingTeam.classType, where: LineTrackingTeam.ID.eq(id));

      try {
        final lineTrackingTeamResponse = await Amplify.API.query(request: lineTrackingTeamRequest).response;

        final lineTrackingTeamItems = lineTrackingTeamResponse.data?.items;

        if (lineTrackingTeamItems != null) {
          for (var item in lineTrackingTeamItems) {
            lineTrackingTeams.add(item!);
            if (withRounds){
              await loadLineTrackingTeamRounds(item.id);
            }
            return lineTrackingTeams.firstWhere((element) => element.id == item.id);
          }
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    }
    if (withRounds){
      await loadLineTrackingTeamRounds(id);
      return lineTrackingTeams.firstWhere((element) => element.id == id);
    } else {
      return team;
    }
  }

  Future<LineTrackingMap?> getLineTrackingMap(String id) async {
    // TODO send nested request to get the checkpoints
    final map = lineTrackingMaps.firstWhereOrNull((element) => element.id == id);

    if (map == null) {
      const graphQLDocument = r'''query getLineTrackingMap($id: ID!) {
        getLineTrackingMap(id: $id) {
            id
            day
            checkpoints {
            items {
                id
                linetrackingmapID
                tiles
                gaps
                obstacles
                intersections
                ramps
                speedBumps
                livingVictims
                deadVictims
                seesaws
                number
            }
           }
        }
        }
        ''';

      final request = GraphQLRequest<LineTrackingMap>(
        document: graphQLDocument,
        variables: <String, dynamic>{
          'id': id,
        },
        decodePath: 'getLineTrackingMap',
        modelType: LineTrackingMap.classType,
      );

      final response = await Amplify.API.query(request: request).response;

      final lineTrackingMapsItem = response.data;

      if (lineTrackingMapsItem != null) {
        lineTrackingMaps.add(lineTrackingMapsItem);
        print("length of checkpoints: ${lineTrackingMapsItem.checkpoints!.length}");
        return lineTrackingMapsItem;
      } else {
        return null;
      }
    }

    return map;
  }

  Future<LineTrackingRound?> createLineTrackingRound(LineTrackingRound round, {bool fromLocal=false}) async {

    if (round.scoreDetails == null){
      print("_______________RECIEVED ROUND WITHOUT SCORE DETAILS_______________");
      return null;
    }
    
    if(fromLocal){
      print("----------this round is from local storage");
      print("----------round: ${round.toJson()}");
    }

    try {
      final createLineTrackingRoundRequest = ModelMutations.create(round);

      if(!fromLocal){
        await saveRoundLocally(round);
      }

      final createLineTrackingRoundResponse = await Amplify.API.mutate(request: createLineTrackingRoundRequest).response;

      final lineTrackingRoundItem = createLineTrackingRoundResponse.data;

      if (lineTrackingRoundItem != null) {

        if (!fromLocal){
          await deleteLocalRound(round);
        }

        final team = lineTrackingTeams.firstWhere((element) => element.id == round.linetrackingteamID);

        if (team.lineTrackingRounds == null){
          final lineTrackingRounds = <LineTrackingRound>[];
          lineTrackingRounds.add(lineTrackingRoundItem);
          final updatedTeam = team.copyWith(lineTrackingRounds: lineTrackingRounds);
          lineTrackingTeams.removeWhere((element) => element.id == round.linetrackingteamID);
          lineTrackingTeams.add(updatedTeam);
        } else {
          final updatedTeam = team.copyWith(lineTrackingRounds: [...team.lineTrackingRounds!, lineTrackingRoundItem]);
          lineTrackingTeams.removeWhere((element) => element.id == round.linetrackingteamID);
          lineTrackingTeams.add(updatedTeam);
        }
        return lineTrackingRoundItem;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> saveRoundLocally(LineTrackingRound round) async {

    print("saving started");
    final prefs = await SharedPreferences.getInstance();
    final rounds = prefs.getStringList("rounds") ?? [];
    final maps = prefs.getStringList("maps") ?? [];
    // final totalScores = prefs.getStringList("totalScores") ?? [];
    final checkPointScores = prefs.getStringList(round.id) ?? [];

    // round id as key, round as value
    // round id as key, total score as value
    // round id as key, map as value

    final map = round.lineTrackingMap;
    final totalScore = round.scoreDetails!;
    final _checkPointScores = totalScore.checkPointsScores;

    final roundMap = round.toJson();
    final mapMap = map.toJson();
    // final totalScoreMap = totalScore.toJson();
    final roundsJson = {
      round.id: roundMap
    };

    final mapsJson = {
      round.id: mapMap
    };

    final checkPointScoresList = _checkPointScores.map((e) => e.toJson()).toList();

    rounds.add(jsonEncode(roundsJson));
    maps.add(jsonEncode(mapsJson));
    for (var element in checkPointScoresList) {
      checkPointScores.add(jsonEncode(element));
    }

    // remove duplicates from the three lists without using sets
    for (var i = 0; i < rounds.length; i++) {
      for (var j = i + 1; j < rounds.length; j++) {
        if (rounds[i] == rounds[j]) {
          rounds.removeAt(j);
        }
      }
    }

    for (var i = 0; i < maps.length; i++) {
      for (var j = i + 1; j < maps.length; j++) {
        if (maps[i] == maps[j]) {
          maps.removeAt(j);
        }
      }
    }

    for (var i = 0; i < checkPointScores.length; i++) {
      for (var j = i + 1; j < checkPointScores.length; j++) {
        if (checkPointScores[i] == checkPointScores[j]) {
          checkPointScores.removeAt(j);
        }
      }
    }

    prefs.setStringList("rounds", rounds);
    prefs.setStringList("maps", maps);
    prefs.setStringList(round.id, checkPointScores);

  }

  Future<void> uploadLocalRounds() async {

    final prefs = await SharedPreferences.getInstance();
    final rounds = prefs.getStringList("rounds") ?? [];
    final maps = prefs.getStringList("maps") ?? [];

    for (var round in rounds){
      final roundMapItem = jsonDecode(round);
      final roundID = roundMapItem.keys.first.toString();

      final roundMap = roundMapItem[roundID];
      final lineTrackingRound = LineTrackingRound.fromJson(roundMap);

      final mapMapItemString = maps.firstWhereOrNull((element) => jsonDecode(element).keys.first.toString() == roundID);
      final mapMapItem = mapMapItemString != null ? jsonDecode(mapMapItemString) : null;
      final mapMap = mapMapItem != null ? mapMapItem[roundID] : null;
      final map = mapMap != null ? LineTrackingMap.fromJson(mapMap) : null;

      final checkPointScoresStrings = prefs.getStringList(roundID) ?? [];
      final checkPointScores = checkPointScoresStrings.map((e) => CheckPointScore.fromJson(jsonDecode(e))).toList();

      final roundWithMap = lineTrackingRound.copyWith(lineTrackingMap: map, scoreDetails: TotalScore(checkPointsScores: checkPointScores));

      final createdRound = await createLineTrackingRound(roundWithMap, fromLocal: true);
      if (createdRound != null) {
        rounds.remove(round);
        maps.remove(mapMapItemString);
        prefs.remove(roundID);
      }
      prefs.setStringList("rounds", rounds);
      prefs.setStringList("maps", maps);
    }

  }

  Future<void> deleteLocalRound(LineTrackingRound round) async {

    final roundId = round.id;

    final prefs = await SharedPreferences.getInstance();
    final rounds = prefs.getStringList("rounds") ?? [];
    final maps = prefs.getStringList("maps") ?? [];



    final roundMap = rounds.firstWhereOrNull((element) => jsonDecode(element).keys.first == roundId);
    final mapMap = maps.firstWhereOrNull((element) => jsonDecode(element).keys.first == roundId);


    rounds.remove(roundMap);
    maps.remove(mapMap);

    prefs.setStringList("rounds", rounds);
    prefs.setStringList("maps", maps);
    prefs.remove(roundId);

  }

  Future<bool> deleteRound(LineTrackingRound round) async {
    try {
      final request = ModelMutations.delete(round);
      final response = await Amplify.API.mutate(request: request).response;

      final deletedRound = response.data;

      if (deletedRound != null) {
        final newTeam = getLineTrackingTeam(deletedRound.linetrackingteamID, withRounds: true);
        if (newTeam != null){
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }

    } catch (e) {
      return false;
    }
  }

}