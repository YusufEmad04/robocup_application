part of 'line_tracking_teams_bloc.dart';

abstract class LineTrackingTeamsState extends Equatable {
  const LineTrackingTeamsState();
}

class LineTrackingTeamsInitial extends LineTrackingTeamsState {
  @override
  List<Object> get props => [];
}

class LineTrackingTeamsLoading extends LineTrackingTeamsState {
  @override
  List<Object> get props => [];
}

class LineTrackingTeamsError extends LineTrackingTeamsState {
  @override
  List<Object> get props => [];
}

class LineTrackingTeamsReady extends LineTrackingTeamsState {

  final List<LineTrackingTeam> lineTrackingTeams;

  const LineTrackingTeamsReady({required this.lineTrackingTeams});

  @override
  List<Object> get props => [lineTrackingTeams];
}