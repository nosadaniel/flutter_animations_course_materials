import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/edit_task_button.dart';

import '../../constants/text_styles.dart';
import '../../models/task.dart';
import '../theming/app_theme.dart';
import 'animated_task.dart';

class TaskWithName extends StatelessWidget {
  const TaskWithName(
      {super.key,
      required this.task,
      this.completed = false,
      this.onCompleted,
      this.editTaskButtonBuilder,
      required this.isEditing,
      this.hasCompletedState = true});
  final Task task;
  final bool completed;
  final bool isEditing;
  final bool hasCompletedState;
  final ValueChanged<bool>? onCompleted;
  //for delegating the creation of EditTaskButton to TasksGrid Widget
  final WidgetBuilder? editTaskButtonBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            children: [
              AnimatedTask(
                iconName: task.iconName,
                completed: completed,
                onCompleted: onCompleted,
              ),
              if (editTaskButtonBuilder != null)
                Positioned.fill(
                    child: FractionallySizedBox(
                        widthFactor: EditTaskButton.scaleFactor,
                        heightFactor: EditTaskButton.scaleFactor,
                        alignment: Alignment.bottomRight,
                        child: editTaskButtonBuilder!(context)))
            ],
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
