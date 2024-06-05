import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name_loader.dart';

import '../../models/task.dart';

class TasksGridView extends StatelessWidget {
  const TasksGridView({super.key, required this.tasks});
  final List<Task> tasks;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final crossAxisSpacing = constraints.maxWidth * 0.05;
      final taskWidth = (constraints.maxWidth - crossAxisSpacing) / 2.0;
      const aspectRatio = 0.82;
      final taskHeight = taskWidth / aspectRatio;
      //use max(a, 0.1) to prevent layout error when keyword is visible in modal page
      final minAxisSpacing =
          max((constraints.maxHeight - taskHeight * 3) / 2.0, 0.1);
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: minAxisSpacing,
            childAspectRatio: aspectRatio),
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskWithNameLoader(task: task);
        },
        itemCount: tasks.length,
      );
    });
  }
}
