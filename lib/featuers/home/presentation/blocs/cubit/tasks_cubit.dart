import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:how_to_do/featuers/auth/data/user_model.dart';

import '../../../model/task_model.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());
  Box<Task> taskBox = Hive.box<Task>(CurrentUser.user!.uid!);
  void loadTasks() async {
    emit(TasksLoading());
    try {
      final tasks = taskBox.values.toList();

      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError('Failed to load tasks: $e'));
    }
  }

  void addTask(Task task) async {
    try {
      await taskBox.put(task.id, task);
      loadTasks();
    } catch (e) {
      emit(TasksError('Failed to add task: $e'));
    }
  }

  void updateTask(Task task) async {
    try {
      await taskBox.put(task.id, task);
      loadTasks();
    } catch (e) {
      emit(TasksError('Failed to update task: $e'));
    }
  }

  void deleteTask(String taskId) async {
    try {
      await taskBox.delete(taskId);
      loadTasks();
    } catch (e) {
      emit(TasksError('Failed to delete task: $e'));
    }
  }

  void clearAllTasks() async {
    try {
      await taskBox.clear();
      loadTasks();
    } catch (e) {
      emit(TasksError('Failed to clear tasks: $e'));
    }
  }

  //set task as completed
  void toggleTaskCompletion(String taskId, bool isCompleted) async {
    log("id is $taskId");
    try {
      final task = taskBox.get(taskId);
      if (task != null) {
        final updatedTask = Task(
          id: task.id,
          title: task.title,
          description: task.description,
          dueDate: task.dueDate,
          priority: task.priority,
          isCompleted: isCompleted,
        );
        await taskBox.put(taskId, updatedTask);
        loadTasks();
      }
    } catch (e) {
      log("error in set completed");
    }
  }

  //change task color
  void changeTaskColor(String taskId, Color color) async {
    try {
      final task = taskBox.get(taskId);
      if (task != null) {
        log("in color change to ${color.toString()}", name: "the changeTask Color $taskId");
        final updatedTask = Task(
          id: task.id,
          title: task.title,
          description: task.description,
          dueDate: task.dueDate,
          priority: task.priority,
          isCompleted: task.isCompleted,
          backgroundColorValue: color.value,
        );
        await taskBox.put(taskId, updatedTask);
        loadTasks();
      }
    } catch (e) {
      log("error in set completed");
    }
  }
}
