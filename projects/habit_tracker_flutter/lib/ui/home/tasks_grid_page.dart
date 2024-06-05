import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/home/home_page_bottom_options.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_view.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

import '../../models/task.dart';

class TasksGridPage extends StatelessWidget {
  const TasksGridPage({super.key, required this.tasks, this.onFlip});
  final List<Task> tasks;
  final VoidCallback? onFlip;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: SafeArea(
          child: _TasksGridContent(
        tasks: tasks,
        onFlip: onFlip,
      )),
    );
  }
}

class _TasksGridContent extends StatelessWidget {
  const _TasksGridContent({super.key, required this.tasks, this.onFlip});
  final List<Task> tasks;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: TasksGridView(tasks: tasks),
          ),
        ),
        HomePageBottomOptions(onFlip: onFlip)
      ],
    );
  }
}
