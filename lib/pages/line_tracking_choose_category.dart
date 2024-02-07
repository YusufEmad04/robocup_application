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
          children: [
            ListTile(
              title: const Text("Primary"),
              onTap: (){
                context.go("/line-tracking/primary");
              },
            ),
            ListTile(
              title: const Text("Open"),
              onTap: (){
                context.go("/line-tracking/open");
              },
            )
          ]
        ),
      ),
    );
  }
}
