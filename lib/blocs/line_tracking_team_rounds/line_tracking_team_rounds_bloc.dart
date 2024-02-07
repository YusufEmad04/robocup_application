import 'dart:async';
import 'package:collection/collection.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:robocup/models/LineTrackingRound.dart';

import '../../repositories/line_tracking_repository.dart';

part 'line_tracking_team_rounds_event.dart';
part 'line_tracking_team_rounds_state.dart';

class LineTrackingTeamRoundsBloc extends Bloc<LineTrackingTeamRoundsEvent, LineTrackingTeamRoundsState> {

  final LineTrackingRepository lineTrackingRepository;

  LineTrackingTeamRoundsBloc({required this.lineTrackingRepository}) : super(LineTrackingTeamRoundsInitial()) {
    on<LineTrackingTeamRoundsLoad>(_onLineTrackingTeamRoundsLoad);
    on<LineTrackingTeamRoundsRefresh>(_onLineTrackingTeamRoundsRefresh);
    on<LineTrackingRoundsDeleteRound>(_onLineTrackingRoundsDeleteRound);
  }

  void _onLineTrackingTeamRoundsLoad(LineTrackingTeamRoundsLoad event, Emitter<LineTrackingTeamRoundsState> emit) async {
    emit(LineTrackingTeamRoundsLoading());
    final team = await lineTrackingRepository.getLineTrackingTeam(event.teamID, withRounds: true);
    if (team != null) {
      if (team.lineTrackingRounds != null){
        emit(LineTrackingTeamRoundsReady(lineTrackingTeamRounds: team.lineTrackingRounds!, category: event.category, teamId: event.teamID, teamName: team.name));
      } else {
        emit(LineTrackingTeamRoundsReady(lineTrackingTeamRounds: [], category: event.category, teamId: event.teamID, teamName: team.name));
      }
    } else {
      emit(LineTrackingTeamRoundsReady(lineTrackingTeamRounds: [], category: event.category, teamId: event.teamID, teamName: ''));
    }
  }

  void _onLineTrackingTeamRoundsRefresh(LineTrackingTeamRoundsRefresh event, Emitter<LineTrackingTeamRoundsState> emit) async {
    final team = lineTrackingRepository.lineTrackingTeams.firstWhereOrNull((element) => element.id == event.teamID);
    if (team != null) {
      if (team.lineTrackingRounds != null){
        emit(LineTrackingTeamRoundsReady(lineTrackingTeamRounds: team.lineTrackingRounds!, category: event.category, teamId: event.teamID, teamName: team.name));
      } else {
        emit(LineTrackingTeamRoundsReady(lineTrackingTeamRounds: [], category: event.category, teamId: event.teamID, teamName: team.name));
      }
    } else {
      add(LineTrackingTeamRoundsLoad(category: event.category, teamID: event.teamID));
      emit(LineTrackingTeamRoundsLoading());
    }
  }

  void _onLineTrackingRoundsDeleteRound(LineTrackingRoundsDeleteRound event, Emitter<LineTrackingTeamRoundsState> emit) async {
    // delete from the repository using deleteRound
    final team = lineTrackingRepository.lineTrackingTeams.firstWhereOrNull((element) => element.id == event.teamID);
    if (team != null) {
      final rounds = team.lineTrackingRounds;
      if (rounds != null){
        final roundDeleted = await lineTrackingRepository.deleteRound(event.round);
        if (roundDeleted){
          final newRounds = rounds.where((element) => element.id != event.round.id).toList();
          emit(LineTrackingTeamRoundsReady(lineTrackingTeamRounds: newRounds, category: event.category, teamId: event.teamID, teamName: team.name));
        } else {
          emit(LineTrackingTeamRoundsReady(lineTrackingTeamRounds: rounds, category: event.category, teamId: event.teamID, teamName: team.name));
        }
      }
    }
  }
}
