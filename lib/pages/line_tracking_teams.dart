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
    // first letter capital
    final categoryText = category[0].toUpperCase() + category.substring(1);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('$categoryText Line Tracking Teams'),
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

class LineTrackingTeamsItems extends StatefulWidget {
  final String category;
  final List<LineTrackingTeam> lineTrackingTeams;
  const LineTrackingTeamsItems({required this.category, required this.lineTrackingTeams, super.key});

  @override
  State<LineTrackingTeamsItems> createState() => _LineTrackingTeamsItemsState();
}

class _LineTrackingTeamsItemsState extends State<LineTrackingTeamsItems> {

  TextEditingController editingController = TextEditingController();

  var items = <LineTrackingTeam>[];

  void filterSearchResults(String query) {
    setState(() {
      items = widget.lineTrackingTeams.where((team) {
        // return team.name.toLowerCase().contains(query.toLowerCase());
        //search by name and id at the same time (id might be null so we should check for that)
        bool nameContains = team.name.toLowerCase().contains(query.toLowerCase());
        bool hasID = team.robocupID != null;
        bool idContains = hasID ? team.robocupID!.toLowerCase().contains(query.toLowerCase()) : false;
        return nameContains || idContains;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    items = editingController.text.isEmpty ? widget.lineTrackingTeams : items;

    if (widget.lineTrackingTeams.isEmpty){
      return const Center(
        child: Text("No checkpoints found"),
      );
    }
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text("Team: ${items[index].name}"),
                  subtitle: Text("ID: ${items[index].robocupID}"),
                  onTap: (){
                    // context.go("/line-tracking/teams/rounds/${lineTrackingTeams[index].id}");
                    context.go("/line-tracking/${widget.category}/teams/rounds/${items[index].id}");
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
