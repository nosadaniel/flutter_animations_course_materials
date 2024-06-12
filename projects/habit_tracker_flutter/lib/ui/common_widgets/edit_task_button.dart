import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/constants/app_colors.dart';

import '../theming/app_theme.dart';

class EditTaskButton extends StatelessWidget {
  const EditTaskButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  static const scaleFactor = 0.33;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.of(context).accent,
        boxShadow: [
          BoxShadow(
            color: AppColors.black20,
            spreadRadius: 1.5,
            blurRadius: 2,
          )
        ],
      ),
      child: IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            AppAssets.threeDots,
            width: 16,
            height: 16,
          )),
    );
  }
}
