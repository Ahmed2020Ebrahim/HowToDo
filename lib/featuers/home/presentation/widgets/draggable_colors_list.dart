import 'package:flutter/material.dart';

import '../../../../utils/constants/texts.dart';

class DraggableColorsList extends StatelessWidget {
  const DraggableColorsList({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,

      itemCount: Appcolor.draggableColorsList.length,
      itemBuilder: (context, index) {
        final colors = Appcolor.draggableColorsList;

        return Draggable<Color>(
          // ToDo : data that will dragged
          data: colors[index],

          // ToDo : the widget that follows the finger while dragging
          feedback: FeedBackColor(color: colors[index]),

          // ToDo : The widget shown in place of child during dragging.
          childWhenDragging: ChildWhenDraggingWidget(color: colors[index]),

          // ToDo : The widget shown normally (before dragging).
          child: ChildWidget(color: colors[index]),
        );
      },
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class ChildWhenDraggingWidget extends StatelessWidget {
  const ChildWhenDraggingWidget({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: color.withValues(alpha: 0.6), shape: BoxShape.circle),
    );
  }
}

class FeedBackColor extends StatelessWidget {
  const FeedBackColor({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: color.withValues(alpha: 0.6), shape: BoxShape.circle),
    );
  }
}
