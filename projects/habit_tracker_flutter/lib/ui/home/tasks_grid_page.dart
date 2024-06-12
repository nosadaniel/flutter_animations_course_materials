import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/ui/home/home_page_bottom_options.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel_animator.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_selection_close.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_selection_list.dart';
import 'package:habit_tracker_flutter/ui/theming/animated_app_theme.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

import '../../models/task.dart';

class TasksGridPage extends StatelessWidget {
  const TasksGridPage({
    Key? key,
    required this.tasks,
    this.onFlip,
    required this.leftAnimatorKey,
    required this.rightAnimatorKey,
    required this.themeSettings,
    this.onColorIndexSelected,
    this.onVariantIndexSelected,
    required this.gridKey,
  }) : super(key: key);
  final List<Task> tasks;
  final VoidCallback? onFlip;

  final GlobalKey<SlidingPanelAnimatorState> leftAnimatorKey;
  final GlobalKey<SlidingPanelAnimatorState> rightAnimatorKey;

  final GlobalKey<TasksGridState> gridKey;

  final AppThemeSettings themeSettings;
  final ValueChanged<int>? onColorIndexSelected;
  final ValueChanged<int>? onVariantIndexSelected;

  void _enterEditMode() {
    leftAnimatorKey.currentState?.slideIn();
    rightAnimatorKey.currentState?.slideIn();
    gridKey.currentState?.enterEditMode();
  }

  void _exitEditMode() {
    leftAnimatorKey.currentState?.slideOut();
    rightAnimatorKey.currentState?.slideOut();
    gridKey.currentState?.exitEditMode();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAppTheme(
      data: themeSettings.themeData,
      duration: Duration(milliseconds: 500),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppTheme.of(context).primary,
          body: SafeArea(
              child: Stack(
            children: [
              _TasksGridContent(
                gridKey: gridKey,
                tasks: tasks,
                onFlip: onFlip,
                onEnterEditMode: _enterEditMode,
              ),
              Positioned(
                bottom: 6,
                left: 0,
                width: SlidingPanel.leftPanelFixedWidth,
                child: SlidingPanelAnimator(
                  key: leftAnimatorKey,
                  direction: SlideDirection.leftToRight,
                  child: ThemeSelectionClose(onPressed: _exitEditMode),
                ),
              ),
              Positioned(
                bottom: 6,
                right: 0,
                width: MediaQuery.sizeOf(context).width -
                    SlidingPanel.leftPanelFixedWidth,
                child: SlidingPanelAnimator(
                  key: rightAnimatorKey,
                  direction: SlideDirection.rightToLeft,
                  child: ThemeSelectionList(
                    currentThemeSettings: themeSettings,
                    availableWidth: MediaQuery.sizeOf(context).width -
                        SlidingPanel.leftPanelFixedWidth -
                        SlidingPanel.paddingWidth,
                    onColorIndexSelected: onColorIndexSelected,
                    onVariantIndexSelected: onVariantIndexSelected,
                  ),
                ),
              ),
            ],
          )),
        );
      }),
    );
  }
}

class _TasksGridContent extends StatelessWidget {
  const _TasksGridContent({
    Key? key,
    required this.tasks,
    this.onFlip,
    this.onEnterEditMode,
    this.onExitEditMode,
    required this.gridKey,
  }) : super(key: key);
  final List<Task> tasks;
  final VoidCallback? onFlip;
  final GlobalKey<TasksGridState> gridKey;
  final VoidCallback? onEnterEditMode;
  final VoidCallback? onExitEditMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: TasksGrid(
              tasks: tasks,
              key: gridKey,
            ),
          ),
        ),
        HomePageBottomOptions(
          onFlip: onFlip,
          onEnterEditMode: onEnterEditMode,
        )
      ],
    );
  }
}
