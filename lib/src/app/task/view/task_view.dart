import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_app_zybra/src/app/task/model/task_model.dart';
import 'package:task_app_zybra/src/app/task/view/add_edit_task_screen.dart';
import 'package:task_app_zybra/src/app/task/viewmodel/task_provider.dart';

class TaskView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    print("UI: Tasks updated, count = ${tasks.length}"); // Debugging

    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: RefreshIndicator( // ✅ Allows manual refresh
        onRefresh: () async {
          await ref.read(taskProvider.notifier).loadTasks();
        },
        child: tasks.isEmpty
            ? Center(child: Text("No Tasks Found"))
            : ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            return Card(
              child: ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: task.isCompleted,
                      onChanged: (val) {
                        ref.read(taskProvider.notifier).updateTask(
                          task,
                          Task(
                            title: task.title,
                            description: task.description,
                            isCompleted: !task.isCompleted,
                            dueDate: task.dueDate,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AddEditTaskScreen(task: task);
                              },
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        ref.read(taskProvider.notifier).deleteTask(task);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AddEditTaskScreen();
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
