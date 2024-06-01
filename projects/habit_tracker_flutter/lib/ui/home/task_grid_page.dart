import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_view.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskGridPage extends StatelessWidget {
  const TaskGridPage({super.key, required this.tasks});
  final List<TaskPreset> tasks;
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
  final List<TaskPreset> tasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
      child: TasksGridView(tasks: tasks),
    );
  }
}
