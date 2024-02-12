import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'maze_team_scoring_event.dart';
part 'maze_team_scoring_state.dart';

class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}

class MazeTeamScoringBloc extends Bloc<MazeTeamScoringEvent, MazeTeamScoringState> {

  static const int duration = 60 * 8;
  final Ticker _ticker = const Ticker();
  StreamSubscription<int>? _tickerSubscription;
  int currentDuration = duration;

  MazeTeamScoringBloc() : super(MazeTeamScoringInitial()) {

    on<MazeTeamScoringTimerStarted>(_onMazeTeamScoringTimerStarted);
    on<MazeTeamScoringTimerPaused>(_onMazeTeamScoringTimerPaused);
    on<MazeTeamScoringTimerResumed>(_onMazeTeamScoringTimerResumed);
    on<_MazeTeamScoringTimerTicked>(_onMazeTeamScoringTimerTicked);
    on<MazeTeamScoringTimerReset>(_onMazeTeamScoringTimerReset);
    on<MazeTeamScoringLoad>(_onMazeTeamScoringLoad);
  }

  void _onMazeTeamScoringLoad(MazeTeamScoringLoad event, Emitter<MazeTeamScoringState> emit) async {
    _tickerSubscription?.cancel();
    emit(const MazeTeamScoringReady(timerState: TimerInitial(duration)));
  }

  void _onMazeTeamScoringTimerStarted(MazeTeamScoringTimerStarted event, Emitter<MazeTeamScoringState> emit) async {
    _tickerSubscription?.cancel();
    add(const _MazeTeamScoringTimerTicked(duration));
    _tickerSubscription = _ticker
        .tick(ticks: duration)
        .listen((duration) {
      currentDuration = duration;
      add(_MazeTeamScoringTimerTicked(duration));
    });
  }

  void _onMazeTeamScoringTimerPaused(MazeTeamScoringTimerPaused event, Emitter<MazeTeamScoringState> emit) async {
    if (state is MazeTeamScoringReady) {
      if ((state as MazeTeamScoringReady).timerState is TimerRunInProgress) {
        _tickerSubscription?.pause();
        emit((state as MazeTeamScoringReady).copyWith(timerState: TimerRunPause((state as MazeTeamScoringReady).timerState.time)));
      }
    }
  }

  void _onMazeTeamScoringTimerResumed(MazeTeamScoringTimerResumed event, Emitter<MazeTeamScoringState> emit) async {
    if (state is MazeTeamScoringReady) {
      if ((state as MazeTeamScoringReady).timerState is TimerRunPause) {
        _tickerSubscription?.resume();
        emit((state as MazeTeamScoringReady).copyWith(timerState: TimerRunInProgress((state as MazeTeamScoringReady).timerState.time)));
      }
    }
  }

  void _onMazeTeamScoringTimerTicked(_MazeTeamScoringTimerTicked event, Emitter<MazeTeamScoringState> emit) async {
    emit(MazeTeamScoringReady(timerState: TimerRunInProgress(event.duration)));
  }

  void _onMazeTeamScoringTimerReset(MazeTeamScoringTimerReset event, Emitter<MazeTeamScoringState> emit) async {
    _tickerSubscription?.cancel();
    emit(MazeTeamScoringInitial());
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

}
