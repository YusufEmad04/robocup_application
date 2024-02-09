import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MazeDashboard extends StatelessWidget {
  const MazeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Maze Dashboard'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              width: constraints.maxWidth * 0.8,
              height: constraints.maxHeight * 0.6,
              // color: Theme.of(context).colorScheme.primary,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // const Text("Choose Category", style: Th,)
                    Text("Choose category", style: Theme.of(context).textTheme.headlineLarge),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            context.go("/line-tracking/primary");
                          },
                          child: const Text("Edit Maps"),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            context.go("/line-tracking/open");
                          },
                          child: const Text("View Teams"),
                        )
                      ],
                    )
                  ]
              ),
            ),
          );
        },
      ),
    );
  }
}
