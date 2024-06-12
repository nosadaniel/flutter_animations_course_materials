import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name.dart';

import '../../models/task.dart';

class AddTaskItem extends StatelessWidget {
  const AddTaskItem({super.key, this.onCompleted, this.isEditing = false});
  final VoidCallback? onCompleted;
  final bool isEditing;
  @override
  Widget build(BuildContext context) {
    return TaskWithName(
      task: Task.create(name: "Add a task", iconName: AppAssets.plus),
      hasCompletedState: false,
      isEditing: isEditing,
      onCompleted: (completed) => onCompleted?.call(),
    );
  }
}
