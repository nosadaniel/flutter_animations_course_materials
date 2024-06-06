import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/ui/home/home_page_bottom_options.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_view.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_selection_close.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_selection_list.dart';
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
          child: Stack(
        children: [
          _TasksGridContent(
            tasks: tasks,
            onFlip: onFlip,
          ),
          Positioned(
            bottom: 6,
            left: 0,
            width: SlidingPanel.leftPanelFixedWidth,
            child: SlidingPanel(
              direction: SlideDirection.leftToRight,
              child: ThemeSelectionClose(),
            ),
          ),
          Positioned(
            bottom: 6,
            right: 0,
            width: MediaQuery.sizeOf(context).width -
                SlidingPanel.leftPanelFixedWidth,
            child: SlidingPanel(
              direction: SlideDirection.rightToLeft,
              child: ThemeSelectionList(
                currentThemeSettings:
                    AppThemeSettings(colorIndex: 0, variantIndex: 0),
                availableWidth: MediaQuery.sizeOf(context).width -
                    SlidingPanel.leftPanelFixedWidth -
                    SlidingPanel.paddingWidth,
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class _TasksGridContent extends StatelessWidget {
  const _TasksGridContent({required this.tasks, this.onFlip});
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
