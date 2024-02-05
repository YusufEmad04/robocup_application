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

  const LineTrackingTeamRoundsReady(
      {required this.lineTrackingTeamRounds,
      required this.category,
      required this.teamId});

  @override
  List<Object> get props => [lineTrackingTeamRounds, category, teamId];
}
