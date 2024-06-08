import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/presistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel_animator.dart';
import 'package:hive/hive.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

import '../../models/task.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final pageFlipKey = GlobalKey<PageFlipBuilderState>();
  final frontSlidingPanelLeftAnimatorKey =
      GlobalKey<SlidingPanelAnimatorState>();
  final frontSlidingPanelRightAnimatorKey =
      GlobalKey<SlidingPanelAnimatorState>();
  final backSlidingPanelLeftAnimatorKey =
      GlobalKey<SlidingPanelAnimatorState>();
  final backSlidingPanelRightAnimatorKey =
      GlobalKey<SlidingPanelAnimatorState>();

  @override
  Widget build(BuildContext context) {
    final dataStore = ref.watch(dataStoreProvider);
    return PageFlipBuilder(
      key: pageFlipKey,
      frontBuilder: (_) => ValueListenableBuilder<Box<Task>>(
        valueListenable: dataStore.frontTaskListenable(),
        builder: (_, Box<Task> box, __) => TasksGridPage(
          key: ValueKey(1),
          tasks: box.values.toList(),
          onFlip: () {
            pageFlipKey.currentState?.flip();
          },
          leftAnimatorKey: frontSlidingPanelLeftAnimatorKey,
          rightAnimatorKey: frontSlidingPanelRightAnimatorKey,
        ),
      ),
      backBuilder: (_) => ValueListenableBuilder(
        valueListenable: dataStore.backTaskListenable(),
        builder: (_, Box<Task> box, __) => TasksGridPage(
          key: ValueKey(2),
          tasks: box.values.toList(),
          onFlip: () {
            pageFlipKey.currentState?.flip();
          },
          leftAnimatorKey: backSlidingPanelLeftAnimatorKey,
          rightAnimatorKey: backSlidingPanelRightAnimatorKey,
        ),
      ),
    );
  }
}
