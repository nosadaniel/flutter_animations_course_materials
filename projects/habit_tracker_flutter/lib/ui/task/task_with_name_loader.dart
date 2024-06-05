import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/presistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name.dart';
import 'package:hive/hive.dart';

import '../../presistence/task.dart';
import '../../presistence/task_state.dart';

class TaskWithNameLoader extends ConsumerWidget {
  const TaskWithNameLoader({super.key, required this.task});
  final Task task;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //only use watch inside a build method

    final dataStore = ref.watch(dataStoreProvider);
    return ValueListenableBuilder(
        //listen to taskState lister
        valueListenable: dataStore.taskStateListenable(task: task),
        builder: (BuildContext context, Box<TaskState> box, _) {
          //get the taskState object
          final taskState = dataStore.getTaskState(box, task: task);
          //update completed value
          return TaskWithName(
            task: task,
            completed: taskState.completed,
            onCompleted: (completed) {
              //don't use watch object inside a callback
              // store completed value in hive
              ref
                  .read(dataStoreProvider)
                  .setTaskState(task: task, completed: completed);
            },
          );
        });
  }
}
