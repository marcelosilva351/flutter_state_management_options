import 'package:flutter/material.dart';
import 'package:state_options/repositories/task_repository.dart';
import 'package:state_options/tasks/models/task_model.dart';

class ChangeNotifierTasksController extends ChangeNotifier {
  var repo = TaskRepository();
  List<TaskModel> tasks = [];

  ChangeNotifierTasksController() {
    getTasks();
  }

  getTasks() async {
    tasks = await repo.getAllTasks();
    notifyListeners();
  }

  Future<bool> addTask(TaskModel taskToAdd) async {
    var resultAddTask = await repo.insertTask(taskToAdd);
    if (resultAddTask) {
      getTasks();
      return true;
    }
    return false;
  }

  Future<bool> updateTask(TaskModel taskToAdd) async {
    var resultUpdateTask = await repo.updateTask(taskToAdd);
    if (resultUpdateTask) {
      getTasks();
      return true;
    }
    return false;
  }

  Future<bool> deleteTask(TaskModel taskToAdd) async {
    var resultDeleteTask = await repo.deleteTask(taskToAdd.id);
    if (resultDeleteTask) {
      getTasks();
      return true;
    }
    return false;
  }
}
