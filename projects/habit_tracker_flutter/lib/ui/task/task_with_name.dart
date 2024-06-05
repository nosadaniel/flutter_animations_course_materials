import 'package:flutter/material.dart';

import '../../constants/text_styles.dart';
import '../../models/task.dart';
import '../theming/app_theme.dart';
import 'animated_task.dart';

class TaskWithName extends StatelessWidget {
  const TaskWithName(
      {super.key,
      required this.task,
      this.completed = false,
      this.onCompleted});
  final Task task;
  final bool completed;
  final ValueChanged<bool>? onCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AnimatedTask(
            iconName: task.iconName,
            completed: completed,
            onCompleted: onCompleted,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          task.name.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyles.taskName.copyWith(
            color: AppTheme.of(context).accent,
          ),
        ),
      ],
    );
  }
}
