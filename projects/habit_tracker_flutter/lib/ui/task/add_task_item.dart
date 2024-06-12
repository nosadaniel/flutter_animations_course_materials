import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name.dart';

import '../../models/task.dart';

class AddTaskItem extends StatelessWidget {
  const AddTaskItem({super.key, this.onCompleted});
  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    return TaskWithName(
      hasCompletedState: false,
      task: Task.create(name: "Add a task", iconName: AppAssets.plus),
      onCompleted: (completed) => onCompleted?.call(),
    );
  }
}
