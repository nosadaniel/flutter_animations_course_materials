import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stopwatch_flutter/ui/reset_button.dart';
import 'package:stopwatch_flutter/ui/start_stop_button.dart';
import 'package:stopwatch_flutter/ui/stop_watch_view.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  late Duration _currentlyElapsed = Duration.zero;
  late Duration _previouslyElapsed = Duration.zero;
  Duration get _elapsedTime => _currentlyElapsed + _previouslyElapsed;

  bool _isRunning = false;
  @override
  void initState() {
    _ticker = createTicker((elapsed) {
      setState(() {
        setState(() {
          _currentlyElapsed = elapsed;
        });
      });
    });
    //_ticker.start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _toggleRunning() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        _ticker.start();
      } else {
        _ticker.stop();
        _previouslyElapsed += _currentlyElapsed;
        _currentlyElapsed = Duration.zero;
      }
    });
  }

  void _resetTimer() {
    _ticker.stop();
    setState(() {
      _isRunning = false;
      _currentlyElapsed = Duration.zero;
      _previouslyElapsed = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final double radius = constraint.maxWidth / 2;
        return Stack(
          children: [
            StopWatchView(
              elapsed: _elapsedTime,
              radius: radius,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: 80,
                height: 80,
                child: ResetButton(
                  onPressed: _resetTimer,
                ),
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
