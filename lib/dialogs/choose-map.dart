import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseMapDialog extends StatelessWidget {

  final String teamID;
  const ChooseMapDialog({required this.teamID, super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: request maps with their checkpoints using graphql
    return AlertDialog(
      title: Text("Add Round"),
      content: Text("Are you sure you want to add a round?"),
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
  }
}
