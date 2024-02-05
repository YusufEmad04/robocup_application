import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:robocup/models/Category.dart';
import '../../models/LineTrackingTeam.dart';
import '../../repositories/line_tracking_repository.dart';

part 'line_tracking_teams_event.dart';
part 'line_tracking_teams_state.dart';

class LineTrackingTeamsBloc extends Bloc<LineTrackingTeamsEvent, LineTrackingTeamsState> {

  final LineTrackingRepository lineTrackingRepository;

  LineTrackingTeamsBloc({required this.lineTrackingRepository}) : super(LineTrackingTeamsInitial()) {
    on<LineTrackingTeamsLoad>(_onLineTrackingTeamsLoad);
  }

  void _onLineTrackingTeamsLoad(LineTrackingTeamsLoad event, Emitter<LineTrackingTeamsState> emit) async {
    // emit(LineTrackingTeamsLoading());
    //
    // await lineTrackingRepository.loadLineTrackingTeams();
    // //TODO add get line tracking teams method from repository
    //
    // emit(LineTrackingTeamsReady(lineTrackingTeams: lineTrackingRepository.lineTrackingTeams));

    emit(LineTrackingTeamsLoading());
    final lineTrackingTeams = await lineTrackingRepository.getLineTrackingTeams(event.category);

    if (lineTrackingTeams != null) {
      Category category = event.category == "primary" ? Category.PRIMARY : Category.OPEN;
      emit(LineTrackingTeamsReady(lineTrackingTeams: lineTrackingTeams.where((element) => element.category == category).toList(), category: event.category));
    } else {
      emit(LineTrackingTeamsError());
    }

  }

}
