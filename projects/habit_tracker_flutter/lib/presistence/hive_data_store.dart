import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/presistence/task.dart';
import 'package:habit_tracker_flutter/presistence/task_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

final dataStoreProvider =
    Provider<HiveDataStore>((ref) => throw UnimplementedError());

class HiveDataStore {
  static const String tasksBoxName = "tasksBox";
  static const String taskStateBoxName = "taskStateBox";

  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Task>(TaskAdapter());
    Hive.registerAdapter<TaskState>(TaskStateAdapter());
    await Hive.openBox<Task>(tasksBoxName);
    await Hive.openBox<TaskState>(taskStateBoxName);
  }

  Future<void> createDemoTasks(
      {required List<Task> tasks, bool force = false}) async {
    final box = Hive.box<Task>(tasksBoxName);
    if (box.isEmpty || force == true) {
      await box.clear();
      await box.addAll(tasks);
    }
  }

  // listen for value change
  ValueListenable<Box<Task>> taskListenable() {
    return Hive.box<Task>(tasksBoxName).listenable();
  }

  static String taskStateKey(String id) {
    return "$taskStateBoxName/$id";
  }

  Future<void> setTaskState(
      {required Task task, required bool completed}) async {
    //box name
    final box = Hive.box<TaskState>(taskStateBoxName);
    final taskState = TaskState(taskId: task.id, completed: completed);
    //index by taskStateKey
    final key = taskStateKey(task.id);
    await box.put(key, taskState);
    print("update task value ${box.get(key)}");
  }

  ValueListenable<Box<TaskState>> taskStateListenable({required Task task}) {
    final box = Hive.box<TaskState>(taskStateBoxName);
    final key = taskStateKey(task.id);
    return box.listenable(keys: <String>[key]);
  }

  //return the taskState object
  TaskState getTaskState(Box<TaskState> box, {required Task task}) {
    final box = Hive.box<TaskState>(taskStateBoxName);
    final key = taskStateKey(task.id);
    return box.get(key) ?? TaskState(taskId: task.id, completed: false);
  }
}
