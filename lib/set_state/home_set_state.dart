import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:state_options/repositories/task_repository.dart';
import 'package:state_options/tasks/models/task_model.dart';

class HomeSetState extends StatefulWidget {
  HomeSetState({super.key});

  @override
  State<HomeSetState> createState() => _HomeSetStateState();
}

class _HomeSetStateState extends State<HomeSetState> {
  var repo = TaskRepository();

  List<TaskModel> tasks = [];
  var taskTextField = TextEditingController();

  @override
  void initState() {
    getTasksFromDatabase();
    // TODO: implement initState
    super.initState();
  }

  getTasksFromDatabase() async {
    tasks = await repo.getAllTasks();
    setState(() {});
  }

  addTask() async {
    bool inserted =
        await repo.insertTask(TaskModel(0, taskTextField.text, false));
    if (inserted) {
      getTasksFromDatabase();
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
                title: Text("Ocorreu um erro ao tentar adicionar a tarefa"));
          });
    }
  }

  updateTask(TaskModel task) async {
    bool updated = await repo.updateTask(task);
    if (updated) {
      getTasksFromDatabase();
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
                title: Text("Ocorreu um erro ao tentar adicionar a tarefa"));
          });
    }
  }

  deleteTask(int id) async {
    bool deleted = await repo.deleteTask(id);
    if (deleted) {
      getTasksFromDatabase();
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
                title: Text("Ocorreu um erro ao tentar adicionar a tarefa"));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo List With SetState"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height:
            MediaQuery.of(context).size.height - AppBar().preferredSize.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: taskTextField,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        await addTask();
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
            Expanded(child: Builder(builder: (context) {
              if (tasks.isEmpty) {
                return const Center(
                  child: Text("Nenhuma tarefa cadastrada"),
                );
              }
              return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: ((context, index) {
                    var task = tasks[index];
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
                                  await updateTask(task);
                                },
                                child: Icon(
                                    task.isFinished ? Icons.check : Icons.task,
                                    color: task.isFinished
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await deleteTask(task.id);
                                },
                                child:
                                    const Icon(Icons.delete, color: Colors.red),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }));
            })),
          ],
        ),
      ),
    );
  }
}
