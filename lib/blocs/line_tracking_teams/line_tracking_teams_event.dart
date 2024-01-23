part of 'line_tracking_teams_bloc.dart';

abstract class LineTrackingTeamsEvent extends Equatable {
  const LineTrackingTeamsEvent();
}

class LineTrackingTeamsLoad extends LineTrackingTeamsEvent {
  const LineTrackingTeamsLoad();

  @override
  List<Object> get props => [];
}