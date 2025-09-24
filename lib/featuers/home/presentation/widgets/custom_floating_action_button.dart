import 'package:flutter/material.dart';

import '../../../add_task/presentation/screens/add_task_screen.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Action when the button is tapped
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTaskScreen()));
      },
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add, size: 35, color: Colors.white),
      ),
    );
  }
}
