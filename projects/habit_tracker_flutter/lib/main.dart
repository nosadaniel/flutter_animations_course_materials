import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/constants/front_or_back_side.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/presistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/home_page.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppAssets.preloadSVGs();
  final dataStore = HiveDataStore();
  await dataStore.initHive();
  await dataStore.createDemoTasks(frontTasks: [
    Task.create(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
    Task.create(name: 'Walk the Dog', iconName: AppAssets.dog),
    Task.create(name: 'Do Some Coding', iconName: AppAssets.html),
    Task.create(name: 'Meditate', iconName: AppAssets.meditation),
    Task.create(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
    Task.create(name: 'Sleep 8 Hours', iconName: AppAssets.rest),
  ], backTasks: [
    Task.create(name: 'Take Vitamins', iconName: AppAssets.vitamins),
    Task.create(name: 'Cycle to Work', iconName: AppAssets.bike),
    Task.create(name: 'Wash Your Hands', iconName: AppAssets.washHands),
    Task.create(name: 'Wear a Mask', iconName: AppAssets.mask),
    Task.create(name: 'Brush Your Teeth', iconName: AppAssets.toothbrush),
    Task.create(name: 'Floss Your Teeth', iconName: AppAssets.dentalFloss),
  ], force: false);
  final frontThemeSettings =
      await dataStore.getAppThemeSettings(side: FrontOrBackSide.front);
  final backThemeSettings =
      await dataStore.getAppThemeSettings(side: FrontOrBackSide.back);
  runApp(ProviderScope(
    child: const MyApp(),
    //override dependency
    overrides: [
      dataStoreProvider.overrideWithValue(dataStore),
      frontThemeManagerProvider.overrideWith(
        (ref) => AppThemeManager(
            appThemeSettings: frontThemeSettings,
            dataStore: dataStore,
            side: FrontOrBackSide.front),
      ),
      backThemeManagerProvider.overrideWith(
        (ref) => AppThemeManager(
            appThemeSettings: backThemeSettings,
            dataStore: dataStore,
            side: FrontOrBackSide.back),
      )
    ],
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
        //disable Materila splash effect
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: HomePage(),
    );
  }
}
