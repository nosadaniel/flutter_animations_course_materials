import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/constants/front_or_back_side.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/presistence/hive_data_store.dart';

final frontThemeManagerProvider =
    StateNotifierProvider<AppThemeManager, AppThemeSettings>(
        (ref) => throw UnimplementedError());
final backThemeManagerProvider =
    StateNotifierProvider<AppThemeManager, AppThemeSettings>(
        (ref) => throw UnimplementedError());

class AppThemeManager extends StateNotifier<AppThemeSettings> {
  AppThemeManager(
      {required AppThemeSettings appThemeSettings,
      required this.dataStore,
      required this.side})
      : super(appThemeSettings);

  final HiveDataStore dataStore;
  final FrontOrBackSide side;

  void updateColorIndex(int colorIndex) {
    state = state.copyWith(colorIndex: colorIndex);
    dataStore.setAppThemeSettings(settings: state, side: side);
  }

  void updateVariantIndex(int variantIndex) {
    state = state.copyWith(variantIndex: variantIndex);
    dataStore.setAppThemeSettings(settings: state, side: side);
  }
}
