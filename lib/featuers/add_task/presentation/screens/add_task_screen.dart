import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_to_do/utils/constants/colors.dart';
import 'package:how_to_do/utils/validators/app_validators.dart';

import '../../../../utils/helpers/helper_functions.dart';
import '../../../home/model/task_model.dart';
import '../../../home/model/task_priority.dart';
import '../../../home/presentation/blocs/cubit/tasks_cubit.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  //form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String selectedPriority = 'Low';
  final List<String> priorityOptions = ['Low', 'Medium', 'High'];

  /// on save
  Future<void> onSave() async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder:
              (context) => Center(
                child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 3),
              ),
        );
        await Future.delayed(Duration(seconds: 2));
        await saveTask();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("saved successfully")));
      }
    } catch (e) {
      Navigator.of(context).pop();
      log(e.toString(), name: "Error in saving task");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error in saving task")));
    }
  }

  /// Pick date
  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  /// Pick time
  Future<void> pickTime() async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  //save task to hive
  Future<void> saveTask() async {
    //combine date and time to DateTime
    if (_dateController.text.isEmpty || _timeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please select date and time")));
      return;
    }
    //convert time to 24 hour format
    final combinedDateTime = HelperFunctions.combineDateAndTime(
      _dateController.text,
      _timeController.text,
    );
    log(combinedDateTime.toString(), name: "combinedDateTime");
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      description: _descriptionController.text,
      //convert date and time to DateTime
      dueDate: combinedDateTime,
      backgroundColorValue: AppColors.white.value,
      priority:
          HelperFunctions.enumFromString<Priority>(Priority.values, selectedPriority) ??
          Priority.low,
      createdAt: DateTime.now(),
      isCompleted: false,
    );
    // await Hive.box<Task>('tasks').add(task);
    context.read<TasksCubit>().addTask(task);
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
    _timeController.clear();
    setState(() {
      selectedPriority = 'Low';
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = HelperFunctions.isDarkMode(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          title: Text('New Task'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 90,
          leading: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save action
                onSave();
              },
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              // Task Title
              TextFormField(
                controller: _titleController,
                validator: (value) => AppValidators.notEmpty(value),
                decoration: InputDecoration(
                  fillColor: isDark ? Colors.black : Colors.white,
                  filled: true,
                  labelText: 'Task Title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              // Multi-line Task Description
              TextFormField(
                maxLines: 5,
                minLines: 5,
                controller: _descriptionController,
                validator: (value) => AppValidators.notEmpty(value),
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  fillColor: isDark ? Colors.black : Colors.white,
                  filled: true,
                  labelText: 'Task Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
              // Row(Due Date and Time , date picker and time picker)
              Row(
                children: [
                  // Date Picker TextField
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Due Date",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          validator: (value) => AppValidators.notEmpty(value),
                          decoration: InputDecoration(
                            labelText: "Select Date",
                            prefixIcon: Icon(Icons.calendar_today),
                            fillColor: isDark ? Colors.black : Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onTap: pickDate,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Time Picker TextField
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Due Time",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _timeController,
                          validator: (value) => AppValidators.notEmpty(value),
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Select Time",
                            prefixIcon: Icon(Icons.access_time),
                            fillColor: isDark ? Colors.black : Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onTap: pickTime,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              // priority section
              Text("Priority", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              DropdownButtonFormField<String>(
                value: Priority.low.name,
                items:
                    Priority.values.map((priority) {
                      return DropdownMenuItem<String>(
                        value: priority.name,
                        child: Text(priority.name),
                      );
                    }).toList(),
                decoration: InputDecoration(
                  fillColor: isDark ? Colors.black : Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPriority = newValue!;
                  });
                },
              ),
              SizedBox(height: 20.h),

              //it is commpleted
            ],
          ),
        ),
      ),
    );
  }
}
