part of 'line_tracking_team_scoring_bloc.dart';

abstract class LineTrackingTeamScoringEvent extends Equatable {
  const LineTrackingTeamScoringEvent();
}

class LineTrackingTeamScoringLoad extends LineTrackingTeamScoringEvent {
  final String teamID;
  final String mapID;

  const LineTrackingTeamScoringLoad(this.teamID, this.mapID);

  @override
  List<Object> get props => [teamID, mapID];
}

class LineTrackingTeamScoringTimerStarted extends LineTrackingTeamScoringEvent {
  @override
  List<Object> get props => [];
}

class LineTrackingTeamScoringTimerPaused extends LineTrackingTeamScoringEvent {
  @override
  List<Object> get props => [];
}

class LineTrackingTeamScoringTimerResumed extends LineTrackingTeamScoringEvent {
  @override
  List<Object> get props => [];
}

class LineTrackingTeamScoringTimerReset extends LineTrackingTeamScoringEvent {
  @override
  List<Object> get props => [];
}

class _LineTrackingTeamScoringTimerTicked extends LineTrackingTeamScoringEvent {
  final int duration;

  const _LineTrackingTeamScoringTimerTicked(this.duration);

  @override
  List<Object> get props => [duration];
}