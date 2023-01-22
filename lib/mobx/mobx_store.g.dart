// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$mobxStoreTasks on _mobxStoreTasksBase, Store {
  late final _$tasksAtom =
      Atom(name: '_mobxStoreTasksBase.tasks', context: context);

  @override
  ObservableList<TaskModel> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<TaskModel> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$getTasksAsyncAction =
      AsyncAction('_mobxStoreTasksBase.getTasks', context: context);

  @override
  Future getTasks() {
    return _$getTasksAsyncAction.run(() => super.getTasks());
  }

  late final _$addTaksAsyncAction =
      AsyncAction('_mobxStoreTasksBase.addTaks', context: context);

  @override
  Future<bool> addTaks(TaskModel task) {
    return _$addTaksAsyncAction.run(() => super.addTaks(task));
  }

  late final _$updateTaksAsyncAction =
      AsyncAction('_mobxStoreTasksBase.updateTaks', context: context);

  @override
  Future<bool> updateTaks(TaskModel task) {
    return _$updateTaksAsyncAction.run(() => super.updateTaks(task));
  }

  late final _$deleteTaskAsyncAction =
      AsyncAction('_mobxStoreTasksBase.deleteTask', context: context);

  @override
  Future<bool> deleteTask(TaskModel task) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(task));
  }

  @override
  String toString() {
    return '''
tasks: ${tasks}
    ''';
  }
}
