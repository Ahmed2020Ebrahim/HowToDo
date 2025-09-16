import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:how_to_do/featuers/home/presentation/blocs/cubit/tasks_cubit.dart';

import 'task_card.dart';

class DragTargetTaskCard extends StatefulWidget {
  const DragTargetTaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    this.onEdit,
    this.onCheckChanged,
    required this.isChecked,
    required this.backgroundColor,
    required this.taskId,
  });
  final String title;
  final String subtitle;
  final String date;
  final void Function()? onEdit;
  final void Function(bool?)? onCheckChanged;
  final bool isChecked;
  final Color backgroundColor;
  final String taskId;

  @override
  State<DragTargetTaskCard> createState() => _DragTargetTaskCardState();
}

class _DragTargetTaskCardState extends State<DragTargetTaskCard> {
  late Color chosenColor;
  @override
  void initState() {
    super.initState();
    chosenColor = widget.backgroundColor;
  }

  //change color
  void changeColor(Color newColor) {
    setState(() {
      chosenColor = newColor.withValues(alpha: 0.5);
      context.read<TasksCubit>().changeTaskColor(widget.taskId, chosenColor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Color>(
      // Todo : Action after the item is dropped and accepted.
      onAcceptWithDetails: (value) {
        changeColor(value.data);
        //change color using cubit
      },

      // Todo : Build the widget based on the drag target state.
      builder: (context, candidateData, rejectedData) {
        return TaskCard(
          chosenColor: chosenColor,
          title: widget.title,
          subtitle: widget.subtitle,
          date: widget.date,
          onCheckChanged: widget.onCheckChanged,
          isChecked: widget.isChecked,
        );
      },
    );
  }
}
