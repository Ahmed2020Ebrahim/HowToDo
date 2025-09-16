import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:how_to_do/utils/constants/colors.dart';

import '../../../../utils/constants/texts.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.chosenColor,
    required this.title,
    required this.subtitle,
    required this.date,
    this.onEdit,
    this.onCheckChanged,
    required this.isChecked,
  });

  final Color chosenColor;
  final String title;
  final String subtitle;
  final String date;
  final void Function()? onEdit;
  final void Function(bool?)? onCheckChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    log("the chosen color is $chosenColor", name: "TaskCard");
    return Container(
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width - 40,
      height: 150,
      decoration: BoxDecoration(
        color: chosenColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.deepOrange, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //subtitle
                  Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 15)),
                ],
              ),
              //edit icon
              IconButton(
                onPressed: onEdit,
                icon: Icon(Icons.mode_edit_outlined, color: Colors.black, size: 30),
              ),
            ],
          ),
          SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                date,
                style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppTexts.completed,
                    style: TextStyle(
                      color: isChecked ? AppColors.primary : Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    child: Checkbox(
                      activeColor: AppColors.primary,
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: isChecked,
                      onChanged: onCheckChanged,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
