import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robocup/blocs/maze_team_scoring/maze_team_scoring_bloc.dart';

import '../functtions/functions.dart';

class MazeTeamRoundScoring extends StatelessWidget {
  final String mapID;
  final String teamID;

  const MazeTeamRoundScoring({required this.mapID, required this.teamID, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Maze Team Round Scoring'),
      ),
      body: BlocBuilder<MazeTeamScoringBloc, MazeTeamScoringState>(
        builder: (context, state) {

          if (state is MazeTeamScoringInitial){
            context.read<MazeTeamScoringBloc>().add(MazeTeamScoringLoad(mapID: mapID, teamID: teamID));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MazeTeamScoringReady){
            return LayoutBuilder(
              builder: (context, constraints){
                return Column(
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: const Timer(),
                    ),
                    SizedBox(
                        height: constraints.maxHeight * 0.8,
                        width: constraints.maxWidth,
                        // child: state.timerState is TimerInitial ? AbsorbPointer(
                        //     absorbing: true,
                        //     child: Container(
                        //         color: Colors.grey[300],
                        //         child: CheckPointsItems(checkPoints: state.map.checkpoints!)
                        //     )
                        // ) : CheckPointsItems(checkPoints: state.map.checkpoints!)
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }
}

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MazeTeamScoringBloc, MazeTeamScoringState>(
        buildWhen: (previous, current) {
          if (current is MazeTeamScoringReady && previous is MazeTeamScoringReady) {
            return previous.timerState != current.timerState;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is MazeTeamScoringReady){
            final minutesStr = ((state.timerState.time / 60) % 60).floor().toString().padLeft(2, '0');
            final secondsStr = (state.timerState.time % 60).floor().toString().padLeft(2, '0');
            return Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        SizedBox(
                          height: constraints.maxHeight * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: IconButton(
                                  icon: state.timerState is TimerRunInProgress ? Icon(Icons.pause, size: constraints.maxHeight * 0.6,) : Icon(Icons.play_arrow, size: constraints.maxHeight * 0.6,),
                                  onPressed: (){
                                    if (state.timerState is TimerRunInProgress) {
                                      context.read<MazeTeamScoringBloc>().add(MazeTeamScoringTimerPaused());
                                    } else {
                                      if (state.timerState is TimerRunPause) {
                                        context.read<MazeTeamScoringBloc>().add(MazeTeamScoringTimerResumed());
                                      } else {
                                        context.read<MazeTeamScoringBloc>().add(MazeTeamScoringTimerStarted());
                                      }
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                    child: Text(
                                      '$minutesStr:$secondsStr',
                                      style: MediaQuery.sizeOf(context).height > MediaQuery.sizeOf(context).width ? Theme.of(context).textTheme.displaySmall : Theme.of(context).textTheme.displayLarge,
                                    ),
                                  )
                              ),
                              Expanded(
                                  child: IconButton(
                                    icon: Icon(Icons.replay, size: constraints.maxHeight * 0.6,),
                                    onPressed: (){
                                      // context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringTimerReset());
                                      if (state.timerState is! TimerInitial){
                                        showDialogFunction(context, "Reset Timer", "Are you sure you want to reset the timer?", "Yes", "No").then((value) {
                                          if (value) {
                                            context.read<MazeTeamScoringBloc>().add(MazeTeamScoringTimerReset());
                                          }
                                        });
                                      }
                                    },
                                  )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.3,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              // change size of the button
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(Size(constraints.maxWidth * 0.3, constraints.maxHeight * 0.3)),
                              ),
                              child: const Text("End Round"),
                              onPressed: (){
                                // context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringEndRound());
                                if (state.timerState is! TimerInitial){
                                  showDialogFunction(context, "End Round", "Are you sure you want to end the round?", "Yes", "No").then((value) {
                                    if (value) {
                                      print("end round");
                                      context.read<MazeTeamScoringBloc>().add(const MazeTeamScoringRoundEnded(fromRetry: false));
                                    } else {
                                      print("don't end round");
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  },
                )
            );
          } else {
            return const Placeholder();
          }
        }
    );
  }
}