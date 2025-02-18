import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../app/task/model/task_model.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            isCompleted INTEGER,
            dueDate TEXT
          )
          ''',
        );
      },
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    print("Fetched Tasks: $maps"); // Debugging
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    print("Inserted Task: ${task.toMap()}");
  }

  Future<int> updateTask(Task oldTask, Task newTask) async {
    final db = await database;
    return await db.update(
      'tasks',
      newTask.toMap(),
      where: 'id = ?',
      whereArgs: [oldTask.id],
    );
  }

  Future<int> deleteTask(Task task) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
