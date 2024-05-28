import 'package:flutter/material.dart';
import 'package:stopwatch_flutter/ui/reset_button.dart';
import 'package:stopwatch_flutter/ui/start_stop_button.dart';
import 'package:stopwatch_flutter/ui/stop_watch_ticker_ui.dart';
import 'package:stopwatch_flutter/ui/stop_watch_view.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  ///Global key used to manipulate the state of the StopwatchTickerUI
  final _tickerUIKey = GlobalKey<StopWatchTickerUiState>();
  bool _isRunning = false;

  void _toggleRunning() {
    setState(() {
      _isRunning = !_isRunning;
    });
    _tickerUIKey.currentState?.toggleRunning(_isRunning);
  }

  void _reset() {
    setState(() {
      _isRunning = false;
    });
    _tickerUIKey.currentState?.resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final double radius = constraint.maxWidth / 2;
        return Stack(
          children: [
            StopWatchView(radius: radius),
            StopWatchTickerUi(
              radius: radius,
              key: _tickerUIKey,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: 80,
                height: 80,
                child: ResetButton(onPressed: _reset),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 80,
                height: 80,
                child: StartStopButton(
                  onPressed: _toggleRunning,
                  isRunning: _isRunning,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
