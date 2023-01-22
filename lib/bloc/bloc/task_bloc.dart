import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:state_options/repositories/task_repository.dart';
import 'package:state_options/tasks/models/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  var repo = TaskRepository();
  TaskBloc() : super(TaskInitial()) {
    on<GetAllTasks>((event, emit) async {
      var tasksFromRepository = await repo.getAllTasks();
      emit(TasksLoadedState(tasksFromRepository));
    });

    on<InsertTask>((event, emit) async {
      var resultAddTask = await repo.insertTask(event.task);
      if (resultAddTask) {
        add(GetAllTasks());
      }
    });
  }
}
