import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/presistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';
import 'package:hive/hive.dart';

import '../../presistence/task.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //get task data into the widget tree
    final dataStore = ref.watch(dataStoreProvider);
    return ValueListenableBuilder<Box<Task>>(
      valueListenable: dataStore.taskListenable(),
      builder: (_, Box<Task> box, __) => TasksGridPage(
        tasks: box.values.toList(),
      ),
    );
  }
}
