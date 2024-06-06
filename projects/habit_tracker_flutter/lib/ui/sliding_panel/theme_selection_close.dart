import 'package:flutter/material.dart';

class ThemeSelectionClose extends StatelessWidget {
  const ThemeSelectionClose({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.close),
      //color: AppTheme.of(context).accentNegative,
    );
  }
}
