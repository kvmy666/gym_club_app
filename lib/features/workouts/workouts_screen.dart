import 'package:flutter/material.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workouts')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.play_circle),
            title: Text('Full Body Beginner'),
          ),
          ListTile(
            leading: Icon(Icons.play_circle),
            title: Text('Push Day - Strength'),
          ),
          ListTile(
            leading: Icon(Icons.play_circle),
            title: Text('Yoga Flow - 20 min'),
          ),
        ],
      ),
    );
  }
}
