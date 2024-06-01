import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/home/task_grid_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const tasks = [
      TaskPreset(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
      TaskPreset(name: 'Walk the Dog', iconName: AppAssets.dog),
      TaskPreset(name: 'Do Some Coding', iconName: AppAssets.html),
      TaskPreset(name: 'Meditate', iconName: AppAssets.meditation),
      TaskPreset(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
      TaskPreset(name: 'Sleep 8 Hours', iconName: AppAssets.rest),
    ];
    return TaskGridPage(tasks: tasks);
  }
}
