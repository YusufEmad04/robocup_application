import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:robocup/models/Category.dart';
import 'package:robocup/models/CheckPointScore.dart';
import 'package:robocup/models/LineTrackingMap.dart';

import '../../models/CheckPoint.dart';
import '../../models/LineTrackingRound.dart';
import '../../models/LineTrackingTeam.dart';
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

  LineTrackingRound? round;

  static const int duration = 60 * 8;
  final Ticker _ticker = const Ticker();
  StreamSubscription<int>? _tickerSubscription;
  int currentDuration = duration;

  final LineTrackingRepository lineTrackingRepository;

  TotalScore totalScore = TotalScore(checkPointsScores: []);

  LineTrackingTeam? team;
  LineTrackingMap? map;
  String? category;

  bool exitBonus = false;

  LineTrackingTeamScoringBloc({required this.lineTrackingRepository}) : super(LineTrackingTeamScoringInitial()) {
    on<LineTrackingTeamScoringLoad>(_onLineTrackingTeamScoringLoad);
    on<LineTrackingTeamScoringTimerStarted>(_onLineTrackingTeamScoringTimerStarted);
    on<LineTrackingTeamScoringTimerPaused>(_onLineTrackingTeamScoringTimerPaused);
    on<LineTrackingTeamScoringTimerResumed>(_onLineTrackingTeamScoringTimerResumed);
    on<_LineTrackingTeamScoringTimerTicked>(_onLineTrackingTeamScoringTimerTicked);
    on<LineTrackingTeamScoringTimerReset>(_onLineTrackingTeamScoringTimerReset);
    on<LineTrackingTeamScoringCheckPointScoreEdited>(_onLineTrackingTeamScoringCheckPointScoreEdited);
    on<LineTrackingTeamScoringRoundEnded>(_onLineTrackingTeamScoringRoundEnded);
    on<LineTrackingTeamScoringExit>(_onLineTrackingTeamScoringExit);
  }

  void _onLineTrackingTeamScoringLoad(LineTrackingTeamScoringLoad event, Emitter<LineTrackingTeamScoringState> emit) async {

    print("started uploading from bloc");
    await lineTrackingRepository.uploadLocalRounds();
    print("done uploading from bloc");

    team = await lineTrackingRepository.getLineTrackingTeam(event.teamID);
    map = await lineTrackingRepository.getLineTrackingMap(event.mapID);
    category = event.category;

    _tickerSubscription?.cancel();
    totalScore = totalScore.copyWith(checkPointsScores: []);
    round = null;

    if (team != null && map != null) {
      emit(
          LineTrackingTeamScoringReady(
            team: team!,
            totalScore: totalScore,
            map: map!,
            timerState: const TimerInitial(duration),
            category: event.category,
            exitBonus: false,
          )
      );
    } else {
      emit(LineTrackingTeamScoringError());
    }

  }

  void _onLineTrackingTeamScoringTimerStarted(LineTrackingTeamScoringTimerStarted event, Emitter<LineTrackingTeamScoringState> emit) async {
    _tickerSubscription?.cancel();
    add(_LineTrackingTeamScoringTimerTicked(duration));
    _tickerSubscription = _ticker
        .tick(ticks: duration)
        .listen((duration) {
          currentDuration = duration;
          add(_LineTrackingTeamScoringTimerTicked(duration));
        });
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
      totalScore = totalScore.copyWith(checkPointsScores: []);
      emit((state as LineTrackingTeamScoringReady).copyWith(timerState: const TimerInitial(duration), totalScore: totalScore));
    }
  }

  void _onLineTrackingTeamScoringCheckPointScoreEdited(LineTrackingTeamScoringCheckPointScoreEdited event, Emitter<LineTrackingTeamScoringState> emit) async {
    if (state is LineTrackingTeamScoringReady) {

      if (event.exitBonus != null){
        emit((state as LineTrackingTeamScoringReady).copyWith(exitBonus: event.exitBonus));
        exitBonus = event.exitBonus!;
        return;
      }

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

  void _onLineTrackingTeamScoringRoundEnded(LineTrackingTeamScoringRoundEnded event, Emitter<LineTrackingTeamScoringState> emit) async {
    if (state is LineTrackingTeamScoringReady || state is LineTrackingTeamRoundEndError) {
      _tickerSubscription?.cancel();
      // TODO: add round in the repository
      emit(LineTrackingTeamScoringLoading());

      // save round without team data

      int roundNumber = 1;

      try {
        final teamWithRounds = await lineTrackingRepository.getLineTrackingTeam(team!.id, withRounds: true);
        if (teamWithRounds != null) {
          if (teamWithRounds.lineTrackingRounds != null) {
            // roundNumber = teamWithRounds.lineTrackingRounds!.length + 1;
            final maxRoundNumber = teamWithRounds.lineTrackingRounds!.isNotEmpty ? teamWithRounds.lineTrackingRounds!.map((e) => e.number).reduce((value, element) => value > element ? value : element) : null;
            roundNumber = maxRoundNumber == null ? 1 : maxRoundNumber + 1;
          } else {
            roundNumber = 1;
          }
          // roundNumber = teamWithRounds.lineTrackingRounds == null ? 1 : teamWithRounds.lineTrackingRounds!.length + 1;
        } else {
          // roundNumber = team!.lineTrackingRounds == null ? 1 : team!.lineTrackingRounds!.length + 1;
          if (team!.lineTrackingRounds != null) {
            final maxRoundNumber = team!.lineTrackingRounds!.isNotEmpty ? team!.lineTrackingRounds!.map((e) => e.number).reduce((value, element) => value > element ? value : element) : null;
            roundNumber = maxRoundNumber == null ? 1 : maxRoundNumber + 1;
          }
        }
      } catch (e) {
        // roundNumber = team!.lineTrackingRounds == null ? 1 : team!.lineTrackingRounds!.length + 1;
        if (team!.lineTrackingRounds != null) {
          final maxRoundNumber = team!.lineTrackingRounds!.isNotEmpty ? team!.lineTrackingRounds!.map((e) => e.number).reduce((value, element) => value > element ? value : element) : null;
          roundNumber = maxRoundNumber == null ? 1 : maxRoundNumber + 1;
        }
      }

      // round = LineTrackingRound(
      //   linetrackingteamID: team!.id,
      //   scoreDetails: totalScore,
      //   lineTrackingMap: map!,
      //   number: roundNumber,
      //   lineTrackingRoundLineTrackingMapId: map!.id,
      //   category: category! == "primary" ? Category.PRIMARY : Category.OPEN,
      // );

      round ??= LineTrackingRound(
        linetrackingteamID: team!.id,
        scoreDetails: totalScore,
        lineTrackingMap: map!,
        number: roundNumber,
        lineTrackingRoundLineTrackingMapId: map!.id,
        category: category! == "primary" ? Category.PRIMARY : Category.OPEN,
        time: duration - currentDuration,
        round: exitBonus,
      );


      final result = await lineTrackingRepository.createLineTrackingRound(round!);
      if (result != null) {
        emit(LineTrackingTeamRoundEnd(totalScore: totalScore, map: map!, team: team!, category: category!, time: duration - currentDuration, exitBonus: exitBonus));
      } else {
        //TODO save the data locally so that it is not lost
        emit(LineTrackingTeamRoundEndError());
      }


    }
  }

  void _onLineTrackingTeamScoringExit(LineTrackingTeamScoringExit event, Emitter<LineTrackingTeamScoringState> emit) async {
    _tickerSubscription?.cancel();
    emit(LineTrackingTeamScoringInitial());
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

}
