import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_view.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

import '../../presistence/task.dart';

class TasksGridPage extends StatelessWidget {
  const TasksGridPage({super.key, required this.tasks});
  final List<Task> tasks;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: SafeArea(
          child: _TasksGridContent(
        tasks: tasks,
      )),
    );
  }
}

class _TasksGridContent extends StatelessWidget {
  const _TasksGridContent({
    super.key,
    required this.tasks,
  });
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
      child: TasksGridView(tasks: tasks),
    );
  }
}
