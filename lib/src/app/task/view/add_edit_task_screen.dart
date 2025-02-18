import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/task_model.dart';

import '../viewmodel/task_provider.dart';

class AddEditTaskScreen extends ConsumerStatefulWidget {
  final Task? task; // Null if adding a new task

  const AddEditTaskScreen({Key? key, this.task}) : super(key: key);

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends ConsumerState<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(text: widget.task?.description ?? '');
    _selectedDate = widget.task?.dueDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Enter a title' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Enter a description' : null,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Due Date: ${_selectedDate.toLocal().toString().split(' ')[0]}"),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newTask = Task(
                title: _titleController.text,
                description: _descriptionController.text,
                dueDate: _selectedDate,
              );

              if (widget.task == null) {
                ref.read(taskProvider.notifier).addTask(newTask);
              } else {
                ref.read(taskProvider.notifier).updateTask(widget.task!, newTask);
              }
              Navigator.pop(context);
            }
          },
          child: Text(widget.task == null ? "Add" : "Update"),
        ),
      ],
    );
  }
}
