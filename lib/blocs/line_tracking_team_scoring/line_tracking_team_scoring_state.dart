part of 'line_tracking_team_scoring_bloc.dart';

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

abstract class LineTrackingTeamScoringState extends Equatable {
  const LineTrackingTeamScoringState();
}

class LineTrackingTeamScoringInitial extends LineTrackingTeamScoringState {

  @override
  List<Object> get props => [];
}

class LineTrackingTeamScoringReady extends LineTrackingTeamScoringState {
  final String teamName;
  final List<CheckPoint> checkPoints;
  final TimerState timerState;

  const LineTrackingTeamScoringReady(this.teamName, this.checkPoints, this.timerState);

  LineTrackingTeamScoringReady copyWith({
    String? teamName,
    List<CheckPoint>? checkPoints,
    TimerState? timerState,
  }) {
    return LineTrackingTeamScoringReady(
      teamName ?? this.teamName,
      checkPoints ?? this.checkPoints,
      timerState ?? this.timerState,
    );
  }

  @override
  List<Object> get props => [teamName, checkPoints, timerState];
}

class LineTrackingTeamScoringError extends LineTrackingTeamScoringState {

  @override
  List<Object> get props => [];
}