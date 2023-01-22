// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:state_options/change_notifier_with_provider/change_notifier_controller.dart';
import 'package:state_options/tasks/models/task_model.dart';

class ProviderChangeNotifier extends StatelessWidget {
  const ProviderChangeNotifier({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChangeNotifierTasksController(),
        )
      ],
      child: ChangeNotifierHome(),
    );
  }
}

class ChangeNotifierHome extends StatelessWidget {
  ChangeNotifierHome({super.key});
  var taskTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controller =
        Provider.of<ChangeNotifierTasksController>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChaangeNotifier with provider"),
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
                          if (taskTextField.text == "") {
                            return;
                          }
                          var resultAdd = await controller
                              .addTask(TaskModel(0, taskTextField.text, false));
                          if (!resultAdd) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    title:
                                        Text("Erro ao tentar adicionar tarefa"),
                                  );
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
                child: Builder(builder: ((context) {
                  if (controller.tasks.isEmpty) {
                    return const Center(
                      child: Text("Nenhuma tarefa adicionada"),
                    );
                  }
                  return ListView.builder(
                      itemCount: controller.tasks.length,
                      itemBuilder: (context, index) {
                        var task = controller.tasks[index];
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
                                      var resultUpdate =
                                          await controller.updateTask(task);
                                      if (!resultUpdate) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const AlertDialog(
                                                title: Text(
                                                    "Erro ao tentar adicionar tarefa"),
                                              );
                                            });
                                      }
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
                                      var resultDelete =
                                          await controller.deleteTask(task);
                                      if (!resultDelete) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const AlertDialog(
                                                title: Text(
                                                    "Erro ao tentar adicionar tarefa"),
                                              );
                                            });
                                      }
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
