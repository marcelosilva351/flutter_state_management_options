import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_options/bloc/bloc/task_bloc.dart';
import 'package:state_options/tasks/models/task_model.dart';

class BlocProvierPage extends StatelessWidget {
  const BlocProvierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => TaskBloc(), child: BlocHome());
  }
}

class BlocHome extends StatefulWidget {
  BlocHome({super.key});

  @override
  State<BlocHome> createState() => _MobxHomeState();
}

class _MobxHomeState extends State<BlocHome> {
  var taskTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<TaskBloc>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc"),
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: taskTextField,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          bloc.add(InsertTask(
                              TaskModel(0, taskTextField.text, false)));
                        },
                        child: const Icon(
                          Icons.send,
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Tarefa",
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
              Expanded(
                  child: BlocConsumer<TaskBloc, TaskState>(
                listener: (context, state) {
                  if (state is ErrorState) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(state.messageError),
                          );
                        });
                  }
                },
                bloc: bloc,
                builder: (context, state) {
                  if (state is TaskInitial) {
                    bloc.add(GetAllTasks());
                  }
                  if (state is TasksLoadedState) {
                    if (state.tasks.isEmpty) {
                      return const Center(
                        child: Text("Nenhuma tarefa adicionada"),
                      );
                    }
                    return ListView.builder(
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          var task = state.tasks[index];
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(task.name),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        bloc.add(updateTask(task));
                                      },
                                      child: Icon(
                                          task.isFinished
                                              ? Icons.check
                                              : Icons.task,
                                          color: task.isFinished
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        bloc.add(deleteTask(task));
                                      },
                                      child: const Icon(Icons.delete,
                                          color: Colors.red),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  }
                  return Container();
                },
              )),
            ],
          )),
    );
  }
}
