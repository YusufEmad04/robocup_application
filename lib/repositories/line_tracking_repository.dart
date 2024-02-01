import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:robocup/models/LineTrackingMap.dart';
import 'package:collection/collection.dart';
import '../models/LineTrackingRound.dart';
import '../models/LineTrackingTeam.dart';

class LineTrackingRepository {
  final lineTrackingTeams = <LineTrackingTeam>[];
  final lineTrackingMaps = <LineTrackingMap>[];

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

  Future<List<LineTrackingTeam>?> getLineTrackingTeams() async {
    //TODO implement get line tracking teams method from repository
    // will be used instead of loadLineTrackingTeams

    final lineTrackingTeamsRequest = ModelQueries.list(LineTrackingTeam.classType);
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

  Future<LineTrackingTeam?> getLineTrackingTeam(String id) async {
    final team = lineTrackingTeams.firstWhereOrNull((element) => element.id == id);

    if (team == null){
      final lineTrackingTeamRequest = ModelQueries.list(LineTrackingTeam.classType, where: LineTrackingTeam.ID.eq(id));
      final lineTrackingTeamResponse = await Amplify.API.query(request: lineTrackingTeamRequest).response;

      final lineTrackingTeamItems = lineTrackingTeamResponse.data?.items;

      if (lineTrackingTeamItems != null) {
        for (var item in lineTrackingTeamItems) {
          lineTrackingTeams.add(item!);
          return item;
        }
      } else {
        return null;
      }
    }

    return team;
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

}