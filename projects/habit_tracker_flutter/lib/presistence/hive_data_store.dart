import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/models/task_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

final dataStoreProvider =
    Provider<HiveDataStore>((ref) => throw UnimplementedError());

class HiveDataStore {
  static const String taskStateBoxName = "taskStateBox";
  static const frontTasksBoxName = 'frontTasks';
  static const backTasksBoxName = 'backTasks';
  static String taskStateKey(String id) {
    return "$taskStateBoxName/$id";
  }

  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Task>(TaskAdapter());
    Hive.registerAdapter<TaskState>(TaskStateAdapter());
    //open boxes
    await Hive.openBox<Task>(frontTasksBoxName);
    await Hive.openBox<Task>(backTasksBoxName);
    await Hive.openBox<TaskState>(taskStateBoxName);
  }

  Future<void> createDemoTasks(
      {required List<Task> frontTasks,
      required List<Task> backTasks,
      bool force = false}) async {
    final frontBox = Hive.box<Task>(frontTasksBoxName);
    if (frontBox.isEmpty || force == true) {
      await frontBox.clear();
      await frontBox.addAll(frontTasks);
    }
    final backBox = Hive.box<Task>(backTasksBoxName);
    if (backBox.isEmpty || force == true) {
      await backBox.clear();
      await backBox.addAll(backTasks);
    }
  }

  // frontBox listener
  ValueListenable<Box<Task>> frontTaskListenable() {
    return Hive.box<Task>(frontTasksBoxName).listenable();
  }

  //backBox listener
  ValueListenable<Box<Task>> backTaskListenable() {
    return Hive.box<Task>(backTasksBoxName).listenable();
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
