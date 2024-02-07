part of 'line_tracking_team_rounds_bloc.dart';

abstract class LineTrackingTeamRoundsState extends Equatable {
  const LineTrackingTeamRoundsState();
}

class LineTrackingTeamRoundsInitial extends LineTrackingTeamRoundsState {
  @override
  List<Object> get props => [];
}

class LineTrackingTeamRoundsLoading extends LineTrackingTeamRoundsState {
  @override
  List<Object> get props => [];
}

class LineTrackingTeamRoundsError extends LineTrackingTeamRoundsState {
  @override
  List<Object> get props => [];
}

class LineTrackingTeamRoundsReady extends LineTrackingTeamRoundsState {
  final List<LineTrackingRound> lineTrackingTeamRounds;
  final String category;
  final String teamId;
  final String teamName;

  const LineTrackingTeamRoundsReady(
      {required this.lineTrackingTeamRounds,
      required this.category,
      required this.teamId,
      required this.teamName});

  @override
  List<Object> get props => [lineTrackingTeamRounds, category, teamId, teamName];
}
