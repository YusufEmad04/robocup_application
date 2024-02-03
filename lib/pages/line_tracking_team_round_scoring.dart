import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:robocup/models/CheckPointScore.dart';
import '../blocs/line_tracking_team_scoring/line_tracking_team_scoring_bloc.dart';
import '../models/CheckPoint.dart';


Future<bool> _showDialog(context, String title, String text, String left, String right) async {

  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          text,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text(left),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text(right),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
  if (result != null) {
    return result;
  } else {
    return false;
  }
}

class LineTrackingTeamRoundScoring extends StatelessWidget {

  final String mapID;
  final String teamID;

  const LineTrackingTeamRoundScoring({required this.mapID, required this.teamID, super.key});

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
            if (previous.timerState != current.timerState && previous.map == current.map && previous.team == current.team && previous.totalScore == current.totalScore) {
              if (previous.timerState is TimerInitial || current.timerState is TimerInitial || current.timerState is TimerRunComplete){
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
            if (mapID != state.map.id || teamID != state.team.id) {
              context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringLoad(mapID: mapID, teamID: teamID));
              return const Center(child: CircularProgressIndicator());
            }
            if(state.timerState is TimerRunComplete){
              context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringRoundEnded());
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
          } else if(state is LineTrackingTeamRoundEnd) {

            if (mapID != state.map.id || teamID != state.team.id) {
              context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringLoad(mapID: mapID, teamID: teamID));
              return const Center(child: CircularProgressIndicator());
            }

            final widgets = [];

            for (var checkPoint in state.map.checkpoints!){
              final checkPointScore = state.totalScore.checkPointsScores.firstWhereOrNull((element) => element.checkPointNumber == checkPoint.number);
              if (checkPointScore == null) {
                continue;
              }
              final checkPointTotalLOP = checkPointScore.totalLOP;
              int tilesTotalScore = checkPointScore.tilesPassed;
              if (checkPointTotalLOP == 0) {
                tilesTotalScore *= 5;
              } else if (checkPointTotalLOP == 1) {
                tilesTotalScore *= 3;
              } else if (checkPointTotalLOP == 2) {
                tilesTotalScore *= 1;
              } else {
                tilesTotalScore = 0;
              }

              widgets.add(Text("Check Point ${checkPoint.number}"));
              widgets.add(Text("Number of Tiles: ${checkPoint.tiles}"));
              widgets.add(Text("Total LOP: $checkPointTotalLOP"));
              widgets.add(Text("Tiles Score: ${checkPointScore.tilesPassed} * ${checkPointTotalLOP == 0 ? 5 : checkPointTotalLOP == 1 ? 3 : checkPointTotalLOP == 2 ? 1 : 0} = $tilesTotalScore"));
              widgets.add(checkPoint.gaps! > 0 ? Text("Gaps Score: (gaps passed: ${checkPointScore.gapsPassed} / ${checkPoint.gaps!})      ${checkPointScore.gapsPassed} * 10 = ${checkPointScore.gapsPassed * 10}") : const SizedBox.shrink());
              widgets.add(checkPoint.obstacles! > 0 ? Text("Obstacles Score: (obstacles passed: ${checkPointScore.obstaclesPassed} / ${checkPoint.obstacles!})      ${checkPointScore.obstaclesPassed} * 15 = ${checkPointScore.obstaclesPassed * 15}") : const SizedBox.shrink());
              widgets.add(checkPoint.intersections! > 0 ? Text("Intersections Score: (intersections passed: ${checkPointScore.intersectionsPassed} / ${checkPoint.intersections!})      ${checkPointScore.intersectionsPassed} * 10 = ${checkPointScore.intersectionsPassed * 10}") : const SizedBox.shrink());
              widgets.add(checkPoint.ramps! > 0 ? Text("Ramps Score: (ramps passed: ${checkPointScore.rampsPassed} / ${checkPoint.ramps!})      ${checkPointScore.rampsPassed} * 10 = ${checkPointScore.rampsPassed * 10}") : const SizedBox.shrink());
              widgets.add(checkPoint.speedBumps > 0 ? Text("Speed Bumps Score: (speed bumps passed: ${checkPointScore.speedBumpsPassed} / ${checkPoint.speedBumps})      ${checkPointScore.speedBumpsPassed} * 5 = ${checkPointScore.speedBumpsPassed * 5}") : const SizedBox.shrink());
              widgets.add(checkPoint.seesaws! > 0 ? Text("Seesaws Score: (seesaws passed: ${checkPointScore.seesawsPassed} / ${checkPoint.seesaws!})      ${checkPointScore.seesawsPassed} * 15 = ${checkPointScore.seesawsPassed * 15}") : const SizedBox.shrink());
              widgets.add(const Divider());

            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Round Ended",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  const Divider(),
                  ElevatedButton(
                    onPressed: (){
                      context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringExit());
                      context.go("/line-tracking/teams");
                    },
                    child: const Text("Done"),
                  ),
                  const Divider(),
                  for (var i in widgets) i,
                ]
              ),
            );

          }
          else if (state is LineTrackingTeamRoundEndError) {
            return Center(
              child: ElevatedButton(
                child: const Text("Retry"),
                onPressed: (){
                  context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringRoundEnded());
                },
              ),
            );
          }
          else if (state is LineTrackingTeamScoringLoading) {

            return const Center(child: CircularProgressIndicator());

          } else{
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
                                  context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringTimerPaused());
                                } else {
                                  if (state.timerState is TimerRunPause) {
                                    context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringTimerResumed());
                                  } else {
                                    context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringTimerStarted());
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
                                  _showDialog(context, "Reset Timer", "Are you sure you want to reset the timer?", "Yes", "No").then((value) {
                                    if (value) {
                                      context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringTimerReset());
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
                              _showDialog(context, "End Round", "Are you sure you want to end the round?", "Yes", "No").then((value) {
                                if (value) {
                                  print("end round");
                                  context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringRoundEnded());
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
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              color: Colors.grey[300],
              child: Text("total LOP: $totalLOP",),
            )
        ),
        for (var i in widget.checkPoints) Expanded(
          flex: 3,
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
        ),
        const Expanded(flex: 1, child: SizedBox.shrink())
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
                      child: Icon(Icons.remove, size: constraints.maxWidth * 0.1,),
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
                  width: constraints.maxWidth * 0.3,
                  child: Center(
                      child: Text(
                          widget.maxVal == -1 ? widget.controller.value.toString() : "${widget.controller.value} / ${widget.maxVal}",
                          style: Theme.of(context).textTheme.headlineMedium
                      )
                  )
              ),
              SizedBox(
                  width: constraints.maxWidth * 0.2,
                  child: TextButton(
                      child: Icon(Icons.add, size: constraints.maxWidth * 0.1,),
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
                  width: constraints.maxWidth * 0.3,
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
              width: constraints.maxWidth * 0.7,
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
              width: constraints.maxWidth * 0.3,
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