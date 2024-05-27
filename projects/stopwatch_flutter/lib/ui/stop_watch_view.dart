import 'package:flutter/material.dart';

import 'elapsed_time_text_basic.dart';

class StopWatchView extends StatelessWidget {
  const StopWatchView({super.key, required this.elapsed});
  final Duration elapsed;
  @override
  Widget build(BuildContext context) {
    return ElapsedTimeTextBasic(elapsed: elapsed);
  }
}
