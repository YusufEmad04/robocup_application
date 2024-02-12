import 'package:flutter/material.dart';

class MazeEditMaps extends StatefulWidget {
  const MazeEditMaps({super.key});

  @override
  State<MazeEditMaps> createState() => _MazeEditMapsState();
}

class _MazeEditMapsState extends State<MazeEditMaps> {

  bool visible = false;

  void _onPasswordEntered(String password) {
    if (password == "1234") {
      setState(() {
        visible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return visible ? const MazeEditMapsContent() : MazeEnterPassword(onPasswordEntered: _onPasswordEntered);
  }
}

class MazeEnterPassword extends StatelessWidget {
  // function to be called when enter button is pressed
  final Function(String) onPasswordEntered;
  MazeEnterPassword({required this.onPasswordEntered, super.key});

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // a number field to enter the password and an enter button
    return Center(
      child: Column(
        children: [
          TextField(
            //number only
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Password',
            ),
            controller: passwordController,
          ),
          ElevatedButton(
            onPressed: () {
              onPasswordEntered(passwordController.text);
            },
            child: const Text('Enter'),
          ),
        ],
      ),
    );
  }
}

class MazeEditMapsContent extends StatelessWidget {
  const MazeEditMapsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
