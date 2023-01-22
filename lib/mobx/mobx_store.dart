import 'package:mobx/mobx.dart';
import 'package:state_options/repositories/task_repository.dart';
import 'package:state_options/tasks/models/task_model.dart';
part 'mobx_store.g.dart';

class mobxStoreTasks = _mobxStoreTasksBase with _$mobxStoreTasks;

abstract class _mobxStoreTasksBase with Store {
  var repo = TaskRepository();
  @observable
  ObservableList<TaskModel> tasks = ObservableList.of([]);

  @action
  getTasks() async {
    tasks = ObservableList.of(await repo.getAllTasks());
  }

  @action
  Future<bool> addTaks(TaskModel task) async {
    var resultAddTask = await repo.insertTask(task);
    if (resultAddTask) {
      await getTasks();
      return true;
    }
    return false;
  }

  @action
  Future<bool> updateTaks(TaskModel task) async {
    var resultUpdate = await repo.updateTask(task);
    if (resultUpdate) {
      await getTasks();
      return true;
    }
    return false;
  }

  @action
  Future<bool> deleteTask(TaskModel task) async {
    var resultDelete = await repo.deleteTask(task.id);
    if (resultDelete) {
      await getTasks();
      return true;
    }
    return false;
  }
}
