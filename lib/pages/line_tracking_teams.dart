import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:robocup/models/LineTrackingTeam.dart';

import '../blocs/line_tracking_teams/line_tracking_teams_bloc.dart';

class LineTrackingTeamsPage extends StatelessWidget {
  final String category;
  const LineTrackingTeamsPage({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Line Tracking Teams'),
      ),
      body: BlocBuilder<LineTrackingTeamsBloc, LineTrackingTeamsState>(
        builder: (context, state){
          if(state is LineTrackingTeamsLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LineTrackingTeamsReady){
            if (state.category != category){
              context.read<LineTrackingTeamsBloc>().add(LineTrackingTeamsLoad(category: category));
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return LineTrackingTeamsItems(lineTrackingTeams: state.lineTrackingTeams, category: category);
          } else if(state is LineTrackingTeamsInitial){
            context.read<LineTrackingTeamsBloc>().add(LineTrackingTeamsLoad(category: category));
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      )
    );
  }
}

class LineTrackingTeamsItems extends StatelessWidget {
  final String category;
  final List<LineTrackingTeam> lineTrackingTeams;
  const LineTrackingTeamsItems({required this.category, required this.lineTrackingTeams, super.key});

  @override
  Widget build(BuildContext context) {
    if (lineTrackingTeams.isEmpty){
      return const Center(
        child: Text("No checkpoints found"),
      );
    }
    return ListView.builder(
      itemCount: lineTrackingTeams.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text("Team: ${lineTrackingTeams[index].name}"),
          subtitle: Text("ID: ${lineTrackingTeams[index].robocupID}"),
          onTap: (){
            // context.go("/line-tracking/teams/rounds/${lineTrackingTeams[index].id}");
            context.go("/line-tracking/$category/teams/rounds/${lineTrackingTeams[index].id}");
          },
        );
      },
    );
  }
}
