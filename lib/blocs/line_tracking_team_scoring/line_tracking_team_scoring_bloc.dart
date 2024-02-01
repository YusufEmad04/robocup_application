import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:robocup/models/CheckPointScore.dart';
import 'package:robocup/models/LineTrackingMap.dart';

import '../../models/CheckPoint.dart';
import '../../models/TotalScore.dart';
import '../../repositories/line_tracking_repository.dart';

part 'line_tracking_team_scoring_event.dart';
part 'line_tracking_team_scoring_state.dart';

class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}


class LineTrackingTeamScoringBloc extends Bloc<LineTrackingTeamScoringEvent, LineTrackingTeamScoringState> {

  static const int duration = 60 * 8;
  final Ticker _ticker = const Ticker();
  StreamSubscription<int>? _tickerSubscription;

  final LineTrackingRepository lineTrackingRepository;

  TotalScore totalScore = TotalScore(checkPointsScores: []);

  LineTrackingTeamScoringBloc({required this.lineTrackingRepository}) : super(LineTrackingTeamScoringInitial()) {
    on<LineTrackingTeamScoringLoad>(_onLineTrackingTeamScoringLoad);
    on<LineTrackingTeamScoringTimerStarted>(_onLineTrackingTeamScoringTimerStarted);
    on<LineTrackingTeamScoringTimerPaused>(_onLineTrackingTeamScoringTimerPaused);
    on<LineTrackingTeamScoringTimerResumed>(_onLineTrackingTeamScoringTimerResumed);
    on<_LineTrackingTeamScoringTimerTicked>(_onLineTrackingTeamScoringTimerTicked);
    on<LineTrackingTeamScoringTimerReset>(_onLineTrackingTeamScoringTimerReset);
    on<LineTrackingTeamScoringCheckPointScoreEdited>(_onLineTrackingTeamScoringCheckPointScoreEdited);
  }

  void _onLineTrackingTeamScoringLoad(LineTrackingTeamScoringLoad event, Emitter<LineTrackingTeamScoringState> emit) async {

    final team = await lineTrackingRepository.getLineTrackingTeam(event.teamID);
    final map = await lineTrackingRepository.getLineTrackingMap(event.mapID);

    _tickerSubscription?.cancel();
    totalScore = totalScore.copyWith(checkPointsScores: []);

    if (team != null && map != null) {
      emit(
          LineTrackingTeamScoringReady(
          teamName: team.name,
          totalScore: totalScore,
          map: map,
          timerState: const TimerInitial(duration)
          )
      );
    } else {
      emit(LineTrackingTeamScoringError());
    }

  }

  void _onLineTrackingTeamScoringTimerStarted(LineTrackingTeamScoringTimerStarted event, Emitter<LineTrackingTeamScoringState> emit) async {
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: duration)
        .listen((duration) => add(_LineTrackingTeamScoringTimerTicked(duration)));
  }

  void _onLineTrackingTeamScoringTimerTicked(_LineTrackingTeamScoringTimerTicked event, Emitter<LineTrackingTeamScoringState> emit) async {
    if (state is LineTrackingTeamScoringReady) {
      final timerState = event.duration > 0 ? TimerRunInProgress(event.duration) : const TimerRunComplete();
      emit((state as LineTrackingTeamScoringReady).copyWith(timerState: timerState));
    }
  }

  void _onLineTrackingTeamScoringTimerPaused(LineTrackingTeamScoringTimerPaused event, Emitter<LineTrackingTeamScoringState> emit) async {
    if (state is LineTrackingTeamScoringReady) {
      if ((state as LineTrackingTeamScoringReady).timerState is TimerRunInProgress) {
        _tickerSubscription?.pause();
        emit((state as LineTrackingTeamScoringReady).copyWith(timerState: TimerRunPause((state as LineTrackingTeamScoringReady).timerState.time)));
      }
    }
  }

  void _onLineTrackingTeamScoringTimerResumed(LineTrackingTeamScoringTimerResumed event, Emitter<LineTrackingTeamScoringState> emit) async {
    if (state is LineTrackingTeamScoringReady) {
      if ((state as LineTrackingTeamScoringReady).timerState is TimerRunPause) {
        _tickerSubscription?.resume();
        emit((state as LineTrackingTeamScoringReady).copyWith(timerState: TimerRunInProgress((state as LineTrackingTeamScoringReady).timerState.time)));
      }
    }
  }

  void _onLineTrackingTeamScoringTimerReset(LineTrackingTeamScoringTimerReset event, Emitter<LineTrackingTeamScoringState> emit) async {
    if (state is LineTrackingTeamScoringReady) {
      _tickerSubscription?.cancel();
      emit((state as LineTrackingTeamScoringReady).copyWith(timerState: const TimerInitial(duration)));
    }
  }

  void _onLineTrackingTeamScoringCheckPointScoreEdited(LineTrackingTeamScoringCheckPointScoreEdited event, Emitter<LineTrackingTeamScoringState> emit) async {
    if (state is LineTrackingTeamScoringReady) {


      // totalScore.checkPointsScores.removeWhere((element) => element.checkPointNumber == event.checkPointScore.checkPointNumber);
      // totalScore.checkPointsScores.add(event.checkPointScore);

      final checkPointScores = totalScore.checkPointsScores;
      checkPointScores.removeWhere((element) => element.checkPointNumber == event.checkPointScore.checkPointNumber);
      checkPointScores.add(event.checkPointScore);
      // copy to change the reference
      totalScore = totalScore.copyWith(checkPointsScores: checkPointScores);

      emit((state as LineTrackingTeamScoringReady).copyWith(totalScore: totalScore));

    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

}
