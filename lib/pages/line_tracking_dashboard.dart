import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LineTrackingDashBoard extends StatelessWidget {
  final String category;
  const LineTrackingDashBoard({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Line Tracking Judge Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Line Tracking Dashboard',
            ),
            ElevatedButton(
              child: const Text("View Teams"),
              onPressed: (){
                // context.go("/line-tracking/teams");
                context.go("/line-tracking/$category/teams");
              },
            ),
          ],
        ),
      ),
    );
  }
}
