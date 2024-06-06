import 'package:habit_tracker_flutter/constants/app_colors.dart';
import 'package:hive/hive.dart';

import '../constants/front_or_back_side.dart';
import '../ui/theming/app_theme.dart';

part 'app_theme_settings.g.dart';

@HiveType(typeId: 2)
class AppThemeSettings extends HiveObject {
  AppThemeSettings({required this.colorIndex, required this.variantIndex});

  factory AppThemeSettings.defaults(FrontOrBackSide side) {
    return AppThemeSettings(
      colorIndex: 0,
      variantIndex: side == FrontOrBackSide.front ? 0 : 2,
    );
  }

  //index used to reference one of the colors in AppCcolors
  //Can range between 0 and AppColors.allColors.length - 1
  @HiveField(0)
  final int colorIndex;

  //Index used to reference the currently selected
  //variant for each color
  //Can range between 0 and 2
  @HiveField(1)
  final int variantIndex;

  AppThemeSettings copyWith({int? colorIndex, int? variantIndex}) {
    return AppThemeSettings(
        colorIndex: colorIndex ?? this.colorIndex,
        variantIndex: variantIndex ?? this.variantIndex);
  }

  //actual AppThemeData object to be used by widgets
  AppThemeData get themeData {
    final variants =
        AppThemeVariants(swatch: AppColors.allSwatches[colorIndex]);
    return variants.themes[variantIndex];
  }
}
