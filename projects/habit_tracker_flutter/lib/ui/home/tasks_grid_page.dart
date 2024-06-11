import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/ui/home/home_page_bottom_options.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_view.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel_animator.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_selection_close.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_selection_list.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

import '../../models/task.dart';

class TasksGridPage extends StatelessWidget {
  const TasksGridPage({
    super.key,
    required this.tasks,
    this.onFlip,
    required this.leftAnimatorKey,
    required this.rightAnimatorKey,
    required this.themeSettings,
    this.onColorIndexSelected,
    this.onVariantIndexSelected,
  });
  final List<Task> tasks;
  final VoidCallback? onFlip;

  final GlobalKey<SlidingPanelAnimatorState> leftAnimatorKey;
  final GlobalKey<SlidingPanelAnimatorState> rightAnimatorKey;

  final AppThemeSettings themeSettings;
  final ValueChanged<int>? onColorIndexSelected;
  final ValueChanged<int>? onVariantIndexSelected;

  void _enterEditMode() {
    leftAnimatorKey.currentState?.slideIn();
    rightAnimatorKey.currentState?.slideIn();
  }

  void _closeEditMode() {
    leftAnimatorKey.currentState?.slideOut();
    rightAnimatorKey.currentState?.slideOut();
  }

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      data: themeSettings.themeData,
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppTheme.of(context).primary,
          body: SafeArea(
              child: Stack(
            children: [
              _TasksGridContent(
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
                  child: ThemeSelectionClose(onPressed: _closeEditMode),
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
  const _TasksGridContent(
      {required this.tasks, this.onFlip, this.onEnterEditMode});
  final List<Task> tasks;
  final VoidCallback? onFlip;
  final VoidCallback? onEnterEditMode;

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
        HomePageBottomOptions(
          onFlip: onFlip,
          onEnterEditMode: onEnterEditMode,
        )
      ],
    );
  }
}
