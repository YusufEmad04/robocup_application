part of 'line_tracking_team_scoring_bloc.dart';

abstract class LineTrackingTeamScoringEvent extends Equatable {
  const LineTrackingTeamScoringEvent();
}

class LineTrackingTeamScoringLoad extends LineTrackingTeamScoringEvent {
  final String teamID;
  final String mapID;
  final String category;

  const LineTrackingTeamScoringLoad({required this.teamID, required this.mapID, required this.category});

  @override
  List<Object> get props => [teamID, mapID, category];
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

class LineTrackingTeamScoringCheckPointScoreEdited extends LineTrackingTeamScoringEvent {
  final CheckPointScore checkPointScore;

  const LineTrackingTeamScoringCheckPointScoreEdited(this.checkPointScore);

  @override
  List<Object> get props => [checkPointScore];
}

class LineTrackingTeamScoringRoundEnded extends LineTrackingTeamScoringEvent {

  final bool fromRetry;

  const LineTrackingTeamScoringRoundEnded({required this.fromRetry});

  @override
  List<Object> get props => [fromRetry];
}

class LineTrackingTeamScoringExit extends LineTrackingTeamScoringEvent {
  @override
  List<Object> get props => [];
}

class _LineTrackingTeamScoringTimerTicked extends LineTrackingTeamScoringEvent {
  final int duration;

  const _LineTrackingTeamScoringTimerTicked(this.duration);

  @override
  List<Object> get props => [duration];
}