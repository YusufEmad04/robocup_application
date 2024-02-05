import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:robocup/repositories/line_tracking_repository.dart';

class ChooseMapDialog extends StatelessWidget {

  final String teamID;
  final String category;
  const ChooseMapDialog({required this.category, required this.teamID, super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: request maps with their checkpoints using graphql
    // context.read<LineTrackingRepository>().getLineTrackingMaps();
    return FutureBuilder(
      future: context.read<LineTrackingRepository>().getLineTrackingMaps(),
      builder: (context, snapshot){
        return AlertDialog(
          title: const Text("Add Round"),
          content: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.5,
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: ListView.builder(
              itemCount: context.read<LineTrackingRepository>().lineTrackingMaps.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text("Map: ${context.read<LineTrackingRepository>().lineTrackingMaps[index].day.toString()}"),
                  onTap: (){
                    context.go("/line-tracking/$category/teams/rounds/$teamID/round-scoring/${context.read<LineTrackingRepository>().lineTrackingMaps[index].id}");
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: (){
                context.go("/line-tracking/$category/teams/rounds/$teamID");
              },
            )
          ],
        );
      },
    );
  }
}
