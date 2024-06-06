import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_variant_picker.dart';

import '../../constants/app_colors.dart';

class ThemeSelectionList extends StatefulWidget {
  const ThemeSelectionList(
      {super.key,
      required this.currentThemeSettings,
      required this.availableWidth,
      this.onColorIndexSelected,
      this.onVariantIndexSelected});
  final AppThemeSettings currentThemeSettings;
  final double availableWidth;
  final ValueChanged<int>? onColorIndexSelected;
  final ValueChanged<int>? onVariantIndexSelected;
  @override
  State<ThemeSelectionList> createState() => _ThemeSelectionListState();
}

class _ThemeSelectionListState extends State<ThemeSelectionList> {
  late final ScrollController _controller;

  double get scrollOffset {
    final contentWidth =
        ThemeVariantPicker.itemSize * AppColors.allSwatches.length;
    final selectedIndex = widget.currentThemeSettings.colorIndex;
    final offset = ThemeVariantPicker.itemSize * selectedIndex -
        (widget.availableWidth / 2 - ThemeVariantPicker.itemSize / 2);
    return max(min(offset, contentWidth - widget.availableWidth), 0);
  }

  @override
  void initState() {
    //preset the scroll position
    _controller = ScrollController(initialScrollOffset: scrollOffset);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //pick the first list of colors, red
    final List<Color> allColors =
        AppColors.allSwatches.map((swatch) => swatch[0]).toList();
    return ListView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: [
        for (final color in allColors)
          ThemeVariantPicker(
            color: color,
            isSelected: widget.currentThemeSettings.colorIndex ==
                allColors.indexOf(color),
            selectedVariantIndex: widget.currentThemeSettings.variantIndex,
            onColorSelected: (color) {
              final newColorIndex = allColors.indexOf(color);
              final previousColorIndex = widget.currentThemeSettings.colorIndex;
              if (previousColorIndex != newColorIndex) {
                //set new color
                widget.onColorIndexSelected?.call(allColors.indexOf(color));
              } else {
                final newVariantIndex =
                    (widget.currentThemeSettings.variantIndex + 1) % 3;
                widget.onVariantIndexSelected?.call(newVariantIndex);
              }
            },
          )
      ],
    );
  }
}
