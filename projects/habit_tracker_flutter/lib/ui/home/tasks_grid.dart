import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/animation/custom_fade_transition.dart';
import 'package:habit_tracker_flutter/ui/animation/staggered_scale_transition.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/edit_task_button.dart';
import 'package:habit_tracker_flutter/ui/task/add_task_item.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name_loader.dart';

import '../../models/task.dart';

class TasksGrid extends StatefulWidget {
  const TasksGrid({super.key, required this.tasks});
  final List<Task> tasks;

  @override
  State<TasksGrid> createState() => TasksGridState();
}

class TasksGridState extends State<TasksGrid>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));

  void enterEditMode() {
    _animationController.forward();
    setState(() {
      _isEditing = true;
    });
  }

  void exitEditMode() {
    _animationController.reverse();
    setState(() {
      _isEditing = false;
    });
  }

  @override
  void initState() {
    // _animationCurve =
    //     _animationController.drive(CurveTween(curve: Curves.easeInOut));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isEditing = false;

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
      final tasksLength = min(6, widget.tasks.length + 1);
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: minAxisSpacing,
            childAspectRatio: aspectRatio),
        itemBuilder: (context, index) {
          if (index == widget.tasks.length) {
            return CustomFadeTransition(
              animation: _animationController,
              child: AddTaskItem(
                onCompleted: _isEditing ? () => print("add new item") : null,
              ),
            );
          }
          final task = widget.tasks[index];
          return TaskWithNameLoader(
            task: task,
            isEditing: _isEditing,
            editTaskButtonBuilder: (_) => StaggeredScaleTransition(
                animation: _animationController,
                index: index,
                child: EditTaskButton(onPressed: () => print("Edit Item"))),
          );
        },
        itemCount: tasksLength,
      );
    });
  }
}
