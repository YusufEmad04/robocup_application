import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:robocup/repositories/line_tracking_repository.dart';

class ChooseMapDialog extends StatelessWidget {

  final String teamID;
  const ChooseMapDialog({required this.teamID, super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: request maps with their checkpoints using graphql
    // context.read<LineTrackingRepository>().getLineTrackingMaps();
    return FutureBuilder(
      future: context.read<LineTrackingRepository>().getLineTrackingMaps(),
      builder: (context, snapshot){
        return AlertDialog(
          title: Text("Add Round"),
          content: Container(
            height: MediaQuery.sizeOf(context).height * 0.5,
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: ListView.builder(
              itemCount: context.read<LineTrackingRepository>().lineTrackingMaps.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(context.read<LineTrackingRepository>().lineTrackingMaps[index].day.toString()),
                  onTap: (){
                    print("going to /line-tracking/teams/rounds/$teamID/round-scoring/${context.read<LineTrackingRepository>().lineTrackingMaps[index].id}");
                    context.go("/line-tracking/teams/rounds/$teamID/round-scoring/${context.read<LineTrackingRepository>().lineTrackingMaps[index].id}");
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: (){
                context.go("/line-tracking/teams/rounds/$teamID");
              },
            ),
            TextButton(
              child: Text("Add"),
              onPressed: (){

              },
            )
          ],
        );
      },
    );
  }
}
