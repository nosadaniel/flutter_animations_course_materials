import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stopwatch_flutter/ui/stop_watch_view.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  late Duration _elapsed = Duration.zero;
  @override
  void initState() {
    _ticker = createTicker((elapsed) {
      setState(() {
        setState(() {
          _elapsed = elapsed;
        });
      });
    });
    _ticker.start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StopWatchView(
      elapsed: _elapsed,
    );
  }
}
