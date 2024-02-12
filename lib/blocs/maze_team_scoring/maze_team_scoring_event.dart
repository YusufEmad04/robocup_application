part of 'maze_team_scoring_bloc.dart';

abstract class MazeTeamScoringEvent extends Equatable {
  const MazeTeamScoringEvent();
}

class MazeTeamScoringLoad extends MazeTeamScoringEvent {
  final String teamID;
  final String mapID;

  const MazeTeamScoringLoad({required this.teamID, required this.mapID});

  @override
  List<Object> get props => [];
}

class MazeTeamScoringTimerStarted extends MazeTeamScoringEvent {
  @override
  List<Object> get props => [];
}

class MazeTeamScoringTimerPaused extends MazeTeamScoringEvent {
  @override
  List<Object> get props => [];
}

class MazeTeamScoringTimerResumed extends MazeTeamScoringEvent {
  @override
  List<Object> get props => [];
}

class MazeTeamScoringTimerReset extends MazeTeamScoringEvent {
  @override
  List<Object> get props => [];
}

class MazeTeamScoringRoundEnded extends MazeTeamScoringEvent {
  final bool fromRetry;

  const MazeTeamScoringRoundEnded({required this.fromRetry});

  @override
  List<Object> get props => [fromRetry];
}

class MazeTeamScoringExit extends MazeTeamScoringEvent {
  @override
  List<Object> get props => [];
}

class _MazeTeamScoringTimerTicked extends MazeTeamScoringEvent {
  final int duration;

  const _MazeTeamScoringTimerTicked(this.duration);

  @override
  List<Object> get props => [duration];
}