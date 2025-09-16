import 'package:hive/hive.dart';

import 'task_priority.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final bool isCompleted;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime? dueDate;

  @HiveField(6)
  final int backgroundColorValue; // 👈 stored as int

  @HiveField(7)
  final Priority priority;

  Task({
    required this.id,
    required this.title,
    this.description = "",
    this.isCompleted = false,
    DateTime? createdAt,
    this.dueDate,
    this.priority = Priority.low,
    this.backgroundColorValue = 0xFFFFFFFF, // default white
  }) : createdAt = createdAt ?? DateTime.now();
}
