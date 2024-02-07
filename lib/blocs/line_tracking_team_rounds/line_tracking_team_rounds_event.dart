part of 'line_tracking_team_rounds_bloc.dart';

abstract class LineTrackingTeamRoundsEvent extends Equatable {
  const LineTrackingTeamRoundsEvent();
}

class LineTrackingTeamRoundsLoad extends LineTrackingTeamRoundsEvent {
  final String category;
  final String teamID;
  const LineTrackingTeamRoundsLoad({required this.category, required this.teamID});

  @override
  List<Object> get props => [category, teamID];
}

class LineTrackingTeamRoundsRefresh extends LineTrackingTeamRoundsEvent {
  final String category;
  final String teamID;
  const LineTrackingTeamRoundsRefresh({required this.category, required this.teamID});

  @override
  List<Object> get props => [category, teamID];
}

class LineTrackingRoundsDeleteRound extends LineTrackingTeamRoundsEvent {
  final String category;
  final String teamID;
  final LineTrackingRound round;
  const LineTrackingRoundsDeleteRound({required this.category, required this.teamID, required this.round});

  @override
  List<Object> get props => [category, teamID, round];
}