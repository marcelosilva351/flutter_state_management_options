import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:state_options/mobx/mobx_store.dart';
import 'package:state_options/tasks/models/task_model.dart';

class MobxHome extends StatefulWidget {
  MobxHome({super.key});

  @override
  State<MobxHome> createState() => _MobxHomeState();
}

class _MobxHomeState extends State<MobxHome> {
  var taskTextField = TextEditingController();

  var store = mobxStoreTasks();

  @override
  void initState() {
    store.getTasks();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobx"),
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
                          var resultAdd = await store
                              .addTaks(TaskModel(0, taskTextField.text, false));
                          if (!resultAdd) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                      title: Text(
                                          "Erro ao tentar adicionar tarefa"));
                                });
                          }
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
                child: Observer(builder: ((context) {
                  if (store.tasks.isEmpty) {
                    return const Center(
                      child: Text("Nenhuma tarefa adicionada"),
                    );
                  }
                  return ListView.builder(
                      itemCount: store.tasks.length,
                      itemBuilder: (context, index) {
                        var task = store.tasks[index];
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
                                      var resultUpdate = store.updateTaks(task);
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
                                      var resultDelete = store.deleteTask(task);
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
                })),
              ),
            ],
          )),
    );
  }
}
