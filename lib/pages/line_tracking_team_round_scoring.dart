import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robocup/models/CheckPointScore.dart';
import '../blocs/line_tracking_team_scoring/line_tracking_team_scoring_bloc.dart';
import '../models/CheckPoint.dart';

class LineTrackingTeamRoundScoring extends StatelessWidget {

  final String mapID;
  final String teamID;

  const LineTrackingTeamRoundScoring({required this.mapID, required this.teamID, super.key});

  void _showBackDialog(context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Are you sure you want to leave this page?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Line Tracking Team Round Scoring'),
      ),
      body: BlocBuilder<LineTrackingTeamScoringBloc, LineTrackingTeamScoringState>(

        buildWhen: (previous, current) {
          if (current is LineTrackingTeamScoringReady && previous is LineTrackingTeamScoringReady) {
            // return previous.timerState != current.timerState;
            if (previous.timerState != current.timerState && previous.map == current.map && previous.teamName == current.teamName && previous.totalScore == current.totalScore) {
              if (previous.timerState is TimerInitial || current.timerState is TimerInitial){
                return true;
              }
              return false;
            } else {
              return true;
            }
          } else {
            return true;
          }
        },

        builder: (context, state) {
          if(state is LineTrackingTeamScoringInitial){
            context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringLoad(mapID: mapID, teamID: teamID));
            return const Center(child: CircularProgressIndicator());
          } else if (state is LineTrackingTeamScoringReady) {
            if (mapID != state.map.id) {
              context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringLoad(mapID: mapID, teamID: teamID));
              return const Center(child: CircularProgressIndicator());
            }
            state.map.checkpoints!.sort((a, b) => a.number.compareTo(b.number));
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
                        child: state.timerState is TimerInitial ? AbsorbPointer(
                            absorbing: true,
                            child: Container(
                                color: Colors.grey[300],
                                child: CheckPointsItems(checkPoints: state.map.checkpoints!)
                            )
                        ) : CheckPointsItems(checkPoints: state.map.checkpoints!)
                    ),
                  ],
                );
              },
            );
          } else {
            return Center(
              child: ElevatedButton(
                child: const Text("Retry"),
                onPressed: (){
                  context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringLoad(mapID: mapID, teamID: teamID));
                },
              )
            );
          }
        },
      ),
    );
  }
}

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LineTrackingTeamScoringBloc, LineTrackingTeamScoringState>(
      buildWhen: (previous, current) {
        if (current is LineTrackingTeamScoringReady && previous is LineTrackingTeamScoringReady) {
          return previous.timerState != current.timerState;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is LineTrackingTeamScoringReady){
          final minutesStr = ((state.timerState.time / 60) % 60).floor().toString().padLeft(2, '0');
          final secondsStr = (state.timerState.time % 60).floor().toString().padLeft(2, '0');
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints){
                      return IconButton(
                        icon: state.timerState is TimerRunInProgress ? Icon(Icons.pause, size: constraints.maxHeight * 0.7,) : Icon(Icons.play_arrow, size: constraints.maxHeight * 0.7,),
                        onPressed: (){
                          if (state.timerState is TimerRunInProgress) {
                            context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringTimerPaused());
                          } else {
                            if (state.timerState is TimerRunPause) {
                              context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringTimerResumed());
                            } else {
                              context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringTimerStarted());
                            }
                          }
                        },
                      );
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
                  child: LayoutBuilder(
                    builder: (context, constraints){
                      return IconButton(
                        icon: Icon(Icons.replay, size: constraints.maxHeight * 0.7,),
                        onPressed: (){
                          context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringTimerReset());
                        },
                      );
                    }
                  ),
                ),
              ],
            )
          );
        } else {
          return const Placeholder();
        }
      }
    );
  }
}

class CheckPointsItems extends StatefulWidget {
  final List<CheckPoint> checkPoints;
  const CheckPointsItems({required this.checkPoints, super.key});

  @override
  State<CheckPointsItems> createState() => _CheckPointsItemsState();
}

class _CheckPointsItemsState extends State<CheckPointsItems> {

  int? checkPointScoringIndex;

  @override
  Widget build(BuildContext context) {

    if (context.read<LineTrackingTeamScoringBloc>().state is! LineTrackingTeamScoringReady) {
      return const Text("Error");
    }

    final state = context.read<LineTrackingTeamScoringBloc>().state as LineTrackingTeamScoringReady;
    int totalLOP = 0;

    print("total checkpoint scored: ${state.totalScore.checkPointsScores.length}");
    for (var i in state.totalScore.checkPointsScores) {
      print(i);
      print("-------------------");
      totalLOP += i.totalLOP;
    }

    return checkPointScoringIndex == null?
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: Container(
              alignment: Alignment.center,
              color: Colors.grey[300],
              child: Text("total LOP: $totalLOP",),
            )
        ),
        for (var i in widget.checkPoints) Expanded(
          flex: 2,
          child: ListTile(
            title: Center(
                child: Text(
                    "Check Point ${i.number}",
                    style: Theme.of(context).textTheme.headlineSmall
                )
            ),
            trailing: Builder(
              builder: (context){
                final checkPointScore = state.totalScore.checkPointsScores.firstWhereOrNull((element) => element.checkPointNumber == i.number);
                if (checkPointScore != null) {
                  if (checkPointScore.tilesPassed > 0) {
                    return const Icon(Icons.check, color: Colors.green,);
                  } else {
                    return const Icon(Icons.close, color: Colors.red,);
                  }
                } else {
                  return const Icon(Icons.close, color: Colors.red,);
                }
              }
            ),
            onTap: (){
              setState(() {
                checkPointScoringIndex = widget.checkPoints.indexOf(i);
              });
            },
          ),
        )
      ],
    ) : LayoutBuilder(
      builder: (context, constraints) {

        final int checkPointNumber = widget.checkPoints[checkPointScoringIndex!].number;

        final checkPointScore = state.totalScore.checkPointsScores.firstWhereOrNull((element) => element.checkPointNumber == checkPointNumber);

        int gapsPassed = 0;
        int tilesPassed = 0;
        int obstaclesPassed = 0;
        int intersectionsPassed = 0;
        int rampsPassed = 0;
        int speedBumpsPassed = 0;
        int seesawsPassed = 0;
        int totalLOP = 0;

        // get actual score passed
        if (checkPointScore != null){
          gapsPassed = checkPointScore.gapsPassed;
          tilesPassed = checkPointScore.tilesPassed;
          obstaclesPassed = checkPointScore.obstaclesPassed;
          intersectionsPassed = checkPointScore.intersectionsPassed;
          rampsPassed = checkPointScore.rampsPassed;
          speedBumpsPassed = checkPointScore.speedBumpsPassed;
          seesawsPassed = checkPointScore.seesawsPassed;
          totalLOP = checkPointScore.totalLOP;
        }

        // all controllers under each other
        // get the max value for each item in the checkpoint
        final gapCounter = widget.checkPoints[checkPointScoringIndex!].gaps! > 0 ? IntValue(value: gapsPassed) : null;
        final obstacleCounter = widget.checkPoints[checkPointScoringIndex!].obstacles! > 0 ? IntValue(value: obstaclesPassed) : null;
        final intersectionCounter = widget.checkPoints[checkPointScoringIndex!].intersections! > 0 ? IntValue(value: intersectionsPassed) : null;
        final rampCounter = widget.checkPoints[checkPointScoringIndex!].ramps! > 0 ? IntValue(value: rampsPassed) : null;
        final speedBumpCounter = widget.checkPoints[checkPointScoringIndex!].speedBumps > 0 ? IntValue(value: speedBumpsPassed) : null;
        final seesawCounter = widget.checkPoints[checkPointScoringIndex!].seesaws! > 0 ? IntValue(value: seesawsPassed) : null;
        final lopCounter = IntValue(value: totalLOP);
        final checkPointBool = BoolValue(value: tilesPassed > 0);

        onChanged(){
          context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringCheckPointScoreEdited(
            CheckPointScore(
              checkPointNumber: checkPointNumber,
              gapsPassed: gapCounter != null ? gapCounter.value : 0,
              tilesPassed: checkPointBool.value ? widget.checkPoints[checkPointScoringIndex!].tiles : 0,
              obstaclesPassed: obstacleCounter != null ? obstacleCounter.value : 0,
              intersectionsPassed: intersectionCounter != null ? intersectionCounter.value : 0,
              rampsPassed: rampCounter != null ? rampCounter.value : 0,
              speedBumpsPassed: speedBumpCounter != null ? speedBumpCounter.value : 0,
              seesawsPassed: seesawCounter != null ? seesawCounter.value : 0,
              totalLOP: lopCounter.value,
            )
          ));
        }

        // maxVal for the number after the slash
        final gapCounterWidget = gapCounter != null ? HorizontalCounter(name: "Gaps", maxVal: widget.checkPoints[checkPointScoringIndex!].gaps!, controller: gapCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,) : null;
        final obstacleCounterWidget = obstacleCounter != null ? HorizontalCounter(name: "Obstacles", maxVal: widget.checkPoints[checkPointScoringIndex!].obstacles!, controller: obstacleCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,) : null;
        final intersectionCounterWidget = intersectionCounter != null ? HorizontalCounter(name: "Intersections", maxVal: widget.checkPoints[checkPointScoringIndex!].intersections!, controller: intersectionCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,) : null;
        final rampCounterWidget = rampCounter != null ? HorizontalCounter(name: "Ramps", maxVal: widget.checkPoints[checkPointScoringIndex!].ramps!, controller: rampCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,) : null;
        final speedBumpCounterWidget = speedBumpCounter != null ? HorizontalCounter(name: "Speed Bumps", maxVal: widget.checkPoints[checkPointScoringIndex!].speedBumps, controller: speedBumpCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,) : null;
        final seesawCounterWidget = seesawCounter != null ? HorizontalCounter(name: "Seesaws", maxVal: widget.checkPoints[checkPointScoringIndex!].seesaws!, controller: seesawCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,) : null;
        final lopCounterWidget = HorizontalCounter(name: "LOP", maxVal: -1, controller: lopCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,);

        // final controllers = [gapCounter, obstacleCounter, intersectionCounter, rampCounter, speedBumpCounter, seesawCounter];
        final widgets = [gapCounterWidget, obstacleCounterWidget, intersectionCounterWidget, rampCounterWidget, speedBumpCounterWidget, seesawCounterWidget, lopCounterWidget];

        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i in widgets) i != null ? SizedBox(
                        height: constraints.maxHeight * 0.2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: i,
                        ),
                      ) : const SizedBox.shrink(),
                      HorizontalCheckBox(controller: checkPointBool, onChanged: onChanged,),
                      SizedBox(
                        height: constraints.maxHeight * 0.1,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text("Back"),
                          onPressed: (){
                            setState(() {
                              checkPointScoringIndex = null;
                            });
                          },
                        )
                      ]
                  ),
                ),
              )
            ]
        );
      },
    );
  }
}

class HorizontalCounter extends StatefulWidget {
  final String name;
  final int maxVal;
  final IntValue controller;
  final int checkPointNumber;
  final onChanged;

  const HorizontalCounter({required this.name, required this.maxVal, required this.controller, required this.checkPointNumber, required this.onChanged, super.key});

  @override
  State<HorizontalCounter> createState() => _HorizontalCounterState();
}

class _HorizontalCounterState extends State<HorizontalCounter> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
            children: [
              SizedBox(
                  width: constraints.maxWidth * 0.2,
                  child: TextButton(
                      child: const Icon(Icons.remove),
                      onPressed: (){
                        if (widget.controller.value > 0) {
                          widget.controller.value--;
                        }
                        widget.onChanged();
                        setState(() {});
                      }
                  )
              ),
              // the count and maxVal
              SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: Center(
                      child: Text(
                          widget.maxVal == -1 ? widget.controller.value.toString() : "${widget.controller.value} / ${widget.maxVal}",
                          style: Theme.of(context).textTheme.headlineLarge
                      )
                  )
              ),
              SizedBox(
                  width: constraints.maxWidth * 0.2,
                  child: TextButton(
                      child: const Icon(Icons.add),
                      onPressed: (){
                        // controller value is string so we need to convert it to int
                        if (widget.controller.value < widget.maxVal || widget.maxVal == -1) {
                          widget.controller.value ++;
                        }
                        widget.onChanged();
                        setState(() {});
                      }
                  )
              ),
              SizedBox(
                  width: constraints.maxWidth * 0.2,
                  child: Center(child: Text(widget.name))
              ),
            ]
        );
      }
    );
  }
}

class HorizontalCheckBox extends StatefulWidget {
  final BoolValue controller;
  final onChanged;

  const HorizontalCheckBox({required this.controller, required this.onChanged, super.key});

  @override
  State<HorizontalCheckBox> createState() => _HorizontalCheckBoxState();
}

class _HorizontalCheckBoxState extends State<HorizontalCheckBox> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.8,
              child: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  value: widget.controller.value,
                  onChanged: (value){
                    widget.controller.value = value!;
                    widget.onChanged();
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.2,
              child: const Center(child: Text("CheckPoint Passed"))
            )
          ]
        );
      }
    );
  }
}


class BoolValue{
  bool value;
  BoolValue({required this.value});
}

class IntValue{
  int value;
  IntValue({required this.value});
}