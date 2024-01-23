import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LineTrackingTeamRoundsPage extends StatelessWidget {

  final String teamID;

  const LineTrackingTeamRoundsPage({required this.teamID, super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: Text("Add Round"),
                  onPressed: (){
                    context.go("/line-tracking/teams/rounds/$teamID/choose-map");
                  },
                )
              ]
            )
          ],
        ),
      ),
    );
  }
}
