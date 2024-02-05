import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LineTrackingChooseCategory extends StatelessWidget {
  const LineTrackingChooseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Choose Category'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              child: const Text("Primary"),
              onPressed: (){
                context.go("/line-tracking/primary");
              },
            ),
            ElevatedButton(
              child: const Text("Open"),
              onPressed: (){
                context.go("/line-tracking/open");
              },
            )
          ]
        ),
      ),
    );
  }
}
