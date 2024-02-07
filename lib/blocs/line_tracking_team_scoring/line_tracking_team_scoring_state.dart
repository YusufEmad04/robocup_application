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

class LineTrackingTeamScoringLoading extends LineTrackingTeamScoringState {

  @override
  List<Object> get props => [];
}

class LineTrackingTeamScoringReady extends LineTrackingTeamScoringState {
  final LineTrackingTeam team;
  final TotalScore totalScore;
  final LineTrackingMap map;
  final String category;
  final TimerState timerState;

  const LineTrackingTeamScoringReady({
    required this.team,
    required this.totalScore,
    required this.map,
    required this.category,
    required this.timerState,
  });

  LineTrackingTeamScoringReady copyWith({
    LineTrackingTeam? team,
    TotalScore? totalScore,
    LineTrackingMap? map,
    String? category,
    TimerState? timerState,
  }) {

    return LineTrackingTeamScoringReady(
      team: team ?? this.team,
      totalScore: totalScore ?? this.totalScore,
      map: map ?? this.map,
      category: category ?? this.category,
      timerState: timerState ?? this.timerState,
    );
  }

  @override
  List<Object> get props => [team, totalScore, map, category, timerState];
}

class LineTrackingTeamRoundEnd extends LineTrackingTeamScoringState {
  final TotalScore totalScore;
  final LineTrackingTeam team;
  final LineTrackingMap map;
  final String category;
  final int time;

  const LineTrackingTeamRoundEnd({required this.totalScore, required this.team, required this.map, required this.category, required this.time});

  @override
  List<Object> get props => [totalScore, team, map, category, time];
}

class LineTrackingTeamScoringError extends LineTrackingTeamScoringState {

  @override
  List<Object> get props => [];
}

class LineTrackingTeamRoundEndError extends LineTrackingTeamScoringState {

  @override
  List<Object> get props => [];
}