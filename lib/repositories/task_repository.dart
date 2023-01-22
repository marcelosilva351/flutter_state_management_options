import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:state_options/tasks/models/task_model.dart';

class TaskRepository {
  Future<Database> getDataBase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'state-options.db');

// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Task (id INTEGER PRIMARY KEY, name TEXT, isfinished INTEGER)');
    });
    return database;
  }

  Future<bool> insertTask(TaskModel taskModel) async {
    var database = await getDataBase();

    var values = {'name': taskModel.name, 'isfinished': 0};

    int idResult = await database.insert("Task", values);
    if (idResult != 0) {
      return true;
    }
    return false;
  }

  Future<List<TaskModel>> getAllTasks() async {
    var database = await getDataBase();
    List<Map> tasksFromDatabase = await database.rawQuery("SELECT * FROM Task");
    var tasksModelList = tasksFromDatabase
        .map((task) => TaskModel(
            task["id"], task["name"], task["isfinished"] == 0 ? false : true))
        .toList();
    return tasksModelList;
  }

  Future<bool> updateTask(TaskModel task) async {
    var database = await getDataBase();
    var newTask = {
      "id": task.id,
      "name": task.name,
      "isfinished": task.isFinished ? 0 : 1
    };
    int idResult = await database
        .update("Task", newTask, where: 'id = ?', whereArgs: [task.id]);

    if (idResult != 0) {
      return true;
    }
    return false;
  }

  Future<bool> deleteTask(int id) async {
    var database = await getDataBase();

    int idResult =
        await database.delete("Task", where: 'id = ?', whereArgs: [id]);

    if (idResult != 0) {
      return true;
    }
    return false;
  }
}
