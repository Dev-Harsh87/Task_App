import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final int? id; // Optional: Useful for SQLite
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final bool isCompleted;
  @HiveField(4)
  final DateTime dueDate;

  Task({
    this.id, // ID is optional
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.dueDate,
  });

  // Convert to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'dueDate': dueDate.toIso8601String(),
    };
  }

  // Create Task from Map (for SQLite)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      dueDate: DateTime.parse(map['dueDate']),
    );
  }

  // Copy With method (for easy updates)
  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
