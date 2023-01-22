import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:state_options/repositories/task_repository.dart';
import 'package:state_options/tasks/models/task_model.dart';

Future main() async {
  // Setup sqflite_common_ffi for flutter test
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });
  var repo = TaskRepository();
  test('insert task', () async {
    var id = await repo.insertTask(TaskModel("Testando", false));
    expect(id, true);
  });

  test('get all task', () async {
    var tasks = await repo.getAllTasks();
    expect(tasks.isNotEmpty, true);
  });
}
