import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/constants/app_colors.dart';
import 'package:habit_tracker_flutter/presistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/presistence/task.dart';
import 'package:habit_tracker_flutter/ui/home/home_page.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppAssets.preloadSVGs();
  final dataStore = HiveDataStore();
  await dataStore.initHive();
  await dataStore.createDemoTasks(tasks: [
    Task.create(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
    Task.create(name: 'Walk the Dog', iconName: AppAssets.dog),
    Task.create(name: 'Do Some Coding', iconName: AppAssets.html),
    Task.create(name: 'Meditate', iconName: AppAssets.meditation),
    Task.create(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
    Task.create(name: 'Sleep 8 Hours', iconName: AppAssets.rest),
  ], force: false);
  runApp(ProviderScope(
    child: const MyApp(),
    //override dependency
    overrides: [dataStoreProvider.overrideWithValue(dataStore)],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
      ),
      home: AppTheme(
        data: AppThemeData.defaultWithSwatch(AppColors.red),
        child: const HomePage(),
      ),
    );
  }
}
