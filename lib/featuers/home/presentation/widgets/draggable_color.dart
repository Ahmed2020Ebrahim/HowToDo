import 'package:flutter/material.dart';
import 'package:how_to_do/utils/constants/colors.dart';

import 'draggable_colors_list.dart';
import 'scaleing_button.dart';

class DraggableColorsContainer extends StatefulWidget {
  const DraggableColorsContainer({super.key});
  @override
  State<DraggableColorsContainer> createState() => _DraggableColorsContainerState();
}

class _DraggableColorsContainerState extends State<DraggableColorsContainer> {
  Color chosenColor = Colors.grey;
  //change the color
  void changeColor(Color newColor) {
    setState(() {
      chosenColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScalingButton(
          width: MediaQuery.of(context).size.width,
          // width: 500,
          height: 80,
          triggerButton: Align(
            alignment: Alignment.centerRight,
            child: Container(
              // margin: EdgeInsets.only(left: 300),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              child: const Icon(Icons.brush_outlined, color: Colors.white, size: 30),
            ),
          ),
          expandedChild: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 235, 234, 234),
              borderRadius: BorderRadius.circular(40),
            ),
            child: DraggableColorsList(),
          ),
        ),
      ],
    );
  }
}
