part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TasksLoadedState extends TaskState {
  List<TaskModel> tasks;
  TasksLoadedState(this.tasks);
}
