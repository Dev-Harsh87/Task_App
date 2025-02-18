import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_app_zybra/src/app/task/model/task_model.dart';
import '../../../core/services/db_service.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    loadTasks(); // Load tasks when the app starts
  }

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> loadTasks() async {
    final tasks = await _dbHelper.getTasks();
    print("TaskProvider: Loaded ${tasks.length} tasks"); // Debugging
    state = List.from(tasks); // Always assign a new list reference
  }

  Future<void> addTask(Task task) async {
    await _dbHelper.insertTask(task);
    print("TaskProvider: Task added - ${task.title}"); // Debugging
    loadTasks(); // Reload tasks after adding
  }

  Future<void> updateTask(Task oldTask, Task newTask) async {
    await _dbHelper.updateTask(oldTask, newTask);
    loadTasks(); // Reload tasks after update
  }

  Future<void> deleteTask(Task task) async {
    await _dbHelper.deleteTask(task);
    loadTasks(); // Reload tasks after deletion
  }
}
