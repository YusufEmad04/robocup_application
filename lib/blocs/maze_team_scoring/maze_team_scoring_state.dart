part of 'maze_team_scoring_bloc.dart';

class TimerState extends Equatable {
  final int time;
  const TimerState(this.time);

  @override
  List<Object> get props => [time];
}

class TimerInitial extends TimerState {
  const TimerInitial(super.time);
}

class TimerRunPause extends TimerState {
  const TimerRunPause(super.time);
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.time);
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}

abstract class MazeTeamScoringState extends Equatable {
  const MazeTeamScoringState();
}

class MazeTeamScoringInitial extends MazeTeamScoringState {
  @override
  List<Object> get props => [];
}

class MazeTeamScoringReady extends MazeTeamScoringState {
  final TimerState timerState;

  const MazeTeamScoringReady({
    required this.timerState,
  });

  MazeTeamScoringReady copyWith({
    TimerState? timerState,
  }) {
    return MazeTeamScoringReady(
      timerState: timerState ?? this.timerState,
    );
  }

  @override
  List<Object> get props => [timerState];
}

class MazeTeamScoringLoading extends MazeTeamScoringState {

  @override
  List<Object> get props => [];
}

class MazeTeamScoringError extends MazeTeamScoringState {

  @override
  List<Object> get props => [];
}

class MazeTeamScoringRoundEndError extends MazeTeamScoringState {

  @override
  List<Object> get props => [];
}