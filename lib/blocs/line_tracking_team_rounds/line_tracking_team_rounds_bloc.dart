import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'line_tracking_team_rounds_event.dart';
part 'line_tracking_team_rounds_state.dart';

class LineTrackingTeamRoundsBloc extends Bloc<LineTrackingTeamRoundsEvent, LineTrackingTeamRoundsState> {
  LineTrackingTeamRoundsBloc() : super(LineTrackingTeamRoundsInitial()) {
    on<LineTrackingTeamRoundsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
