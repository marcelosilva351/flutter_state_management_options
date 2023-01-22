part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TasksLoadedState extends TaskState {
  List<TaskModel> tasks;
  TasksLoadedState(this.tasks);
}

class ErrorState extends TaskState {
  String messageError;
  ErrorState(this.messageError);
}
