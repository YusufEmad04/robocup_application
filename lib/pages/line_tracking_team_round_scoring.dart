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
            if (previous.timerState != current.timerState && previous.map == current.map && previous.teamName == current.teamName) {
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
                        child: CheckPointsItems(checkPoints: state.map.checkpoints!)
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

  int? checkPointScoringIndex = null;

  @override
  Widget build(BuildContext context) {

    if (context.read<LineTrackingTeamScoringBloc>().state is! LineTrackingTeamScoringReady) {
      return const Text("Error");
    }

    final state = context.read<LineTrackingTeamScoringBloc>().state as LineTrackingTeamScoringReady;

    return checkPointScoringIndex == null?
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i in widget.checkPoints) Expanded(
          child: ListTile(
            title: Center(
                child: Text(
                    "Check Point ${i.number}",
                    style: Theme.of(context).textTheme.headlineSmall
                )
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

        String gapsPassed = "0";
        String tilesPassed = "0";
        String obstaclesPassed = "0";
        String intersectionsPassed = "0";
        String rampsPassed = "0";
        String speedBumpsPassed = "0";
        String seesawsPassed = "0";
        String totalLOP = "0";

        if (checkPointScore != null){
          gapsPassed = checkPointScore.gapsPassed.toString();
          tilesPassed = checkPointScore.tilesPassed.toString();
          obstaclesPassed = checkPointScore.obstaclesPassed.toString();
          intersectionsPassed = checkPointScore.intersectionsPassed.toString();
          rampsPassed = checkPointScore.rampsPassed.toString();
          speedBumpsPassed = checkPointScore.speedBumpsPassed.toString();
          seesawsPassed = checkPointScore.seesawsPassed.toString();
          totalLOP = checkPointScore.totalLOP.toString();
        }

        // all controllers under each other
        final gapCounter = widget.checkPoints[checkPointScoringIndex!].gaps! > 0 ? TextEditingController(text: gapsPassed) : null;
        final obstacleCounter = widget.checkPoints[checkPointScoringIndex!].obstacles! > 0 ? TextEditingController(text: obstaclesPassed) : null;
        final intersectionCounter = widget.checkPoints[checkPointScoringIndex!].intersections! > 0 ? TextEditingController(text: intersectionsPassed) : null;
        final rampCounter = widget.checkPoints[checkPointScoringIndex!].ramps! > 0 ? TextEditingController(text: rampsPassed) : null;
        final speedBumpCounter = widget.checkPoints[checkPointScoringIndex!].speedBumps > 0 ? TextEditingController(text: speedBumpsPassed) : null;
        final seesawCounter = widget.checkPoints[checkPointScoringIndex!].seesaws! > 0 ? TextEditingController(text: seesawsPassed) : null;
        final lopCounter = TextEditingController(text: totalLOP);

        onChanged(){
          context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringCheckPointScoreEdited(
            CheckPointScore(
              checkPointNumber: checkPointNumber,
              gapsPassed: gapCounter != null ? int.parse(gapCounter.value.text) : 0,
              tilesPassed: widget.checkPoints[checkPointScoringIndex!].tiles,
              obstaclesPassed: obstacleCounter != null ? int.parse(obstacleCounter.value.text) : 0,
              intersectionsPassed: intersectionCounter != null ? int.parse(intersectionCounter.value.text) : 0,
              rampsPassed: rampCounter != null ? int.parse(rampCounter.value.text) : 0,
              speedBumpsPassed: speedBumpCounter != null ? int.parse(speedBumpCounter.value.text) : 0,
              seesawsPassed: seesawCounter != null ? int.parse(seesawCounter.value.text) : 0,
              totalLOP: int.parse(lopCounter.value.text),
              // tilesPassed: widget.checkPoints[checkPointScoringIndex!].tiles,
              // obstaclesPassed: int.parse(obstacleCounter!.value.text),
              // intersectionsPassed: int.parse(intersectionCounter!.value.text),
              // rampsPassed: int.parse(rampCounter!.value.text),
              // speedBumpsPassed: int.parse(speedBumpCounter!.value.text),
              // seesawsPassed: int.parse(seesawCounter!.value.text),
              // totalLOP: int.parse(lopCounter.value.text),
            )
          ));
        }

        final gapCounterWidget = gapCounter != null ? HorizontalCounter(name: "Gaps", maxVal: widget.checkPoints[checkPointScoringIndex!].gaps!, controller: gapCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,) : const SizedBox.shrink();
        final obstacleCounterWidget = obstacleCounter != null ? HorizontalCounter(name: "Obstacles", maxVal: widget.checkPoints[checkPointScoringIndex!].obstacles!, controller: obstacleCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,) : const SizedBox.shrink();
        final intersectionCounterWidget = intersectionCounter != null ? HorizontalCounter(name: "Intersections", maxVal: widget.checkPoints[checkPointScoringIndex!].intersections!, controller: intersectionCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,) : const SizedBox.shrink();
        final rampCounterWidget = rampCounter != null ? HorizontalCounter(name: "Ramps", maxVal: widget.checkPoints[checkPointScoringIndex!].ramps!, controller: rampCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,) : const SizedBox.shrink();
        final speedBumpCounterWidget = speedBumpCounter != null ? HorizontalCounter(name: "Speed Bumps", maxVal: widget.checkPoints[checkPointScoringIndex!].speedBumps, controller: speedBumpCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,) : const SizedBox.shrink();
        final seesawCounterWidget = seesawCounter != null ? HorizontalCounter(name: "Seesaws", maxVal: widget.checkPoints[checkPointScoringIndex!].seesaws!, controller: seesawCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,) : const SizedBox.shrink();
        final lopCounterWidget = HorizontalCounter(name: "LOP", maxVal: -1, controller: lopCounter, checkPointNumber: checkPointNumber, onChanged: onChanged,);

        // final controllers = [gapCounter, obstacleCounter, intersectionCounter, rampCounter, speedBumpCounter, seesawCounter];
        final widgets = [gapCounterWidget, obstacleCounterWidget, intersectionCounterWidget, rampCounterWidget, speedBumpCounterWidget, seesawCounterWidget, lopCounterWidget];

        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: constraints.maxWidth,
                  color: Colors.grey[300],
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i in widgets) i,
                    ],
                  ),
                  // child: ListView.builder(
                  //   itemCount: widgets.length,
                  //   itemBuilder: (context, index) {
                  //     return ListTile(
                  //       title: widgets[index],
                  //     );
                  //   },
                  // ),
                ),
              ),
              Row(
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
  final TextEditingController controller;
  final int checkPointNumber;
  final onChanged;

  const HorizontalCounter({required this.name, required this.maxVal, required this.controller, required this.checkPointNumber, required this.onChanged, super.key});

  @override
  State<HorizontalCounter> createState() => _HorizontalCounterState();
}

class _HorizontalCounterState extends State<HorizontalCounter> {
  @override
  Widget build(BuildContext context) {
    // it will be like this
    // - (count / maxVal) +  (name)
    // decrement button count slash maxVal increment button (name on the right)
    // only buttons are tappable
    // increment and decrement buttons
    // count and maxVal is just a text
    // name is just a text

    // wrap with layout builder and make the label only take the last 20% of the screen width
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
            children: [
              SizedBox(
                  width: constraints.maxWidth * 0.2,
                  child: TextButton(
                      child: const Icon(Icons.remove),
                      onPressed: (){
                        // controller value is string so we need to convert it to int
                        if (int.parse(widget.controller.value.text) > 0) {
                          widget.controller.value = TextEditingValue(text: (int.parse(widget.controller.value.text) - 1).toString());
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
                          widget.maxVal == -1 ? widget.controller.value.text : "${widget.controller.value.text} / ${widget.maxVal}",
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
                        if (int.parse(widget.controller.value.text) < widget.maxVal || widget.maxVal == -1) {
                          widget.controller.value = TextEditingValue(text: (int.parse(widget.controller.value.text) + 1).toString());
                        }

                        // context.read<LineTrackingTeamScoringBloc>().add(LineTrackingTeamScoringCheckPointScoreEdited(
                        //   CheckPointScore(
                        //     checkPointNumber: widget.checkPointNumber,
                        //     gapsP: int.parse(widget.controller.value.text),
                        //   )
                        // ));
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
