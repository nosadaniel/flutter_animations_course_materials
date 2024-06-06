import 'package:flutter/material.dart';

import '../theming/app_theme.dart';

class HomePageBottomOptions extends StatelessWidget {
  const HomePageBottomOptions({super.key, this.onFlip, this.onEnterEditMode});

  final VoidCallback? onFlip;
  final VoidCallback? onEnterEditMode;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onEnterEditMode,
          icon: const Icon(Icons.settings),
          color: AppTheme.of(context).settingsLabel,
        ),
        IconButton(
          onPressed: onFlip,
          icon: Icon(
            Icons.flip,
            color: AppTheme.of(context).settingsLabel,
          ),
        ),
        //invisible widget
        Opacity(
          opacity: 0.0,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        )
      ],
    );
  }
}
