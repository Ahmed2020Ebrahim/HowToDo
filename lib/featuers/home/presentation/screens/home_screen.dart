import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_to_do/utils/constants/colors.dart';
import 'package:how_to_do/utils/helpers/helper_functions.dart';
import '../blocs/cubit/tasks_cubit.dart';
import '../widgets/custom_animated_navbar.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_floating_action_button.dart';
import '../widgets/drag_target_task_card.dart';
import '../widgets/draggable_color.dart';
import '../widgets/wellcom_message.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      //custom app bar
      appBar: CustomAppBar(),

      extendBody: true,
      //custom bottom navigation bar
      bottomNavigationBar: CustomAnimatedNavBar(),

      //custom floating action button
      floatingActionButton: CustomFloatingActionButton(),

      //to center the floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //body
      body: Stack(
        children: [
          Column(
            children: [
              //User wellcom Message
              WellcomMessage(),

              SizedBox(
                height: 500.h,
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20, 25, 20, 125),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //User wellcom Message
                      BlocBuilder<TasksCubit, TasksState>(
                        builder: (context, state) {
                          if (state is TasksLoading) {
                            return SizedBox(
                              height: 400.h,
                              child: const Center(
                                child: CircularProgressIndicator(color: AppColors.primary),
                              ),
                            );
                          } else if (state is TasksLoaded) {
                            final tasks = state.tasks;
                            if (tasks.isEmpty) {
                              return SizedBox(
                                height: 400.h,
                                child: Center(
                                  child: Text(
                                    'No tasks available.',
                                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                                  ),
                                ),
                              );
                            }
                            return Column(
                              children:
                                  tasks
                                      .map(
                                        (task) => Dismissible(
                                          key: Key(task.id),
                                          onDismissed: (direction) {
                                            context.read<TasksCubit>().deleteTask(task.id);
                                          },
                                          confirmDismiss: (direction) async {
                                            //show dialog to confirm deleting
                                            return await showDialog<bool>(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Delete Task'),
                                                  content: Text(
                                                    'Are you sure you want to delete this task?',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop(false);
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop(true);
                                                      },
                                                      child: Text('Delete'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          direction: DismissDirection.endToStart,
                                          background: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                            child: Icon(Icons.delete, color: Colors.white),
                                          ),

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: DragTargetTaskCard(
                                              backgroundColor: Color(task.backgroundColorValue),
                                              title: task.title,
                                              subtitle: task.description,
                                              date: task.dueDate.toString(),
                                              isChecked: task.isCompleted,
                                              taskId: task.id,
                                              onCheckChanged: (value) async {
                                                context.read<TasksCubit>().toggleTaskCompletion(
                                                  task.id,
                                                  !task.isCompleted,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            );
                          } else if (state is TasksError) {
                            return Center(child: Text(state.message));
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          //aligning DraggableColors widget using Positioned
          BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              if (state is TasksLoaded && state.tasks.isNotEmpty) {
                return Positioned(bottom: 120, child: DraggableColorsContainer());
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
