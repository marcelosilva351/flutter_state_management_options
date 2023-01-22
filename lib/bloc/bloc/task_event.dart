part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class GetAllTasks extends TaskEvent {}

class InsertTask extends TaskEvent {
  TaskModel task;
  InsertTask(this.task);
}

class updateTask extends TaskEvent {
  TaskModel task;
  updateTask(this.task);
}

class deleteTask extends TaskEvent {
  TaskModel task;
  deleteTask(this.task);
}
