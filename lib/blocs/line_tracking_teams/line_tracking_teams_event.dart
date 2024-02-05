part of 'line_tracking_teams_bloc.dart';

abstract class LineTrackingTeamsEvent extends Equatable {
  const LineTrackingTeamsEvent();
}

class LineTrackingTeamsLoad extends LineTrackingTeamsEvent {
  final String category;
  const LineTrackingTeamsLoad({required this.category});

  @override
  List<Object> get props => [category];
}