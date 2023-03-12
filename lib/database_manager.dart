import 'dart:async';
import 'package:local_db/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  late Database database;

  Future startDatabase() async {
    database = await openDatabase(
        join(await getDatabasesPath(), "todo_task.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE task_model(id INTEGER PRIMARY KEY autoincrement, task TEXT)",
      );
    });
    return database;
  }

  Future insertTask(TaskModel taskModel) async {
    await startDatabase();
    return await database.insert('task_model', taskModel.toJson());
  }

  Future<List<TaskModel>> getTaskList() async {
    await startDatabase();
    final List<Map<String, dynamic>> maps = await database.query('task_model');

    return List.generate(maps.length, (i) {
      return TaskModel(id: maps[i]['id'], task: maps[i]['task']);
    });
  }

  Future<int> updateTask(TaskModel taskModel) async {
    await startDatabase();
    return await database.update('task_model', taskModel.toJson(),
        where: "id = ?", whereArgs: [taskModel.id]);
  }

  Future<void> deleteTask(TaskModel taskModel) async {
    await startDatabase();
    await database
        .delete('task_model', where: "id = ?", whereArgs: [taskModel.id]);
  }
}
