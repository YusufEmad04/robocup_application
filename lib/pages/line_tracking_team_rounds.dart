import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:robocup/functtions/functions.dart';
import 'package:robocup/models/LineTrackingRound.dart';
import 'package:robocup/repositories/line_tracking_repository.dart';

import '../blocs/line_tracking_team_rounds/line_tracking_team_rounds_bloc.dart';
import '../models/LineTrackingMap.dart';

class LineTrackingTeamRoundsPage extends StatelessWidget {

  final String teamID;
  final String category;

  const LineTrackingTeamRoundsPage({required this.category, required this.teamID, super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LineTrackingTeamRoundsBloc>().add(LineTrackingTeamRoundsRefresh(category: category, teamID: teamID));
    return BlocBuilder<LineTrackingTeamRoundsBloc, LineTrackingTeamRoundsState>(
        builder: (context, state) {
          if (state is LineTrackingTeamRoundsLoading){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Rounds'),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is LineTrackingTeamRoundsInitial){
            context.read<LineTrackingTeamRoundsBloc>().add(LineTrackingTeamRoundsLoad(category: category, teamID: teamID));
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Rounds'),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }  else if (state is LineTrackingTeamRoundsReady){
            if (state.category != category || state.teamId != teamID){
              context.read<LineTrackingTeamRoundsBloc>().add(LineTrackingTeamRoundsLoad(category: category, teamID: teamID));
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: const Text('Rounds'),
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text('${state.teamName} Rounds'),
              ),
              body: Center(
                child: Column(
                  children: [
                    Expanded(child: LineTrackingRounds(rounds: state.lineTrackingTeamRounds, teamID: teamID, category: category)),
                    Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(
                              child: const Text("Add Round"),
                              onPressed: (){
                                // context.go("/line-tracking/teams/rounds/$teamID/choose-map");
                                context.go("/line-tracking/$category/teams/rounds/$teamID/choose-map");
                              },
                            ),
                          )
                        ]
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Rounds'),
              ),
              body: Center(
                child: Column(
                  children: [
                    // Expanded(child: LineTrackingTeamRoundsItems(teamID: teamID)),
                    Row(
                        children: [
                          ElevatedButton(
                            child: const Text("Add Round"),
                            onPressed: (){
                              // context.go("/line-tracking/teams/rounds/$teamID/choose-map");
                              context.go("/line-tracking/$category/teams/rounds/$teamID/choose-map");
                            },
                          )
                        ]
                    )
                  ],
                ),
              ),
            );
          }
        },
    );
  }
}

class LineTrackingRounds extends StatelessWidget {
  final String teamID;
  final String category;
  final List<LineTrackingRound> rounds;
  const LineTrackingRounds({required this.rounds, required this.teamID, required this.category, super.key});
  @override
  Widget build(BuildContext context) {
    // sort by round number
    rounds.sort((a, b) => a.number.compareTo(b.number));
    // rounds.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    return rounds.isEmpty ? const Center(child: Text("No rounds found")) : ListView.builder(
      itemCount: rounds.length,
      itemBuilder: (context, index){

        return ListTile(
          title: Text("Round ${index + 1}"),
          trailing: FutureBuilder(
              future: context.read<LineTrackingRepository>().getLineTrackingMap(rounds[index].lineTrackingRoundLineTrackingMapId),
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                }
                if (snapshot.data == null){
                  return const SizedBox.shrink();
                }
                if (snapshot.data is LineTrackingMap){
                  final map = snapshot.data as LineTrackingMap;
                  final (max, total) = getMaxAndTotalScore(rounds[index].scoreDetails!, map);
                  return Text("Score: $total / $max");
                }
                return const SizedBox.shrink();
              }
          ),
          onTap: (){
            context.go("/line-tracking/$category/teams/rounds/$teamID/round-details/${rounds[index].id}");
          },
          onLongPress: (){
            showDialogFunction(context, "Delete Round", "Are you sure you want to delete this round?", "Delete", "Cancel").then((value) {
              if (value){
                context.read<LineTrackingTeamRoundsBloc>().add(LineTrackingRoundsDeleteRound(category: category, teamID: teamID, round: rounds[index]));
              }
            });
            // context.read<LineTrackingTeamRoundsBloc>().add(LineTrackingRoundsDeleteRound(category: category, teamID: teamID, round: rounds[index]));
          }
        );
      },
    );
  }
}
