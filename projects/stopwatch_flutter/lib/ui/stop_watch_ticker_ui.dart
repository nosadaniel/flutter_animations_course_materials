import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'clock_hand.dart';
import 'elapsed_time_text.dart';

class StopWatchTickerUi extends StatefulWidget {
  const StopWatchTickerUi({super.key, required this.radius});
  final double radius;

  @override
  State<StopWatchTickerUi> createState() => StopWatchTickerUiState();
}

class StopWatchTickerUiState extends State<StopWatchTickerUi>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  late Duration _currentlyElapsed = Duration.zero;
  late Duration _previouslyElapsed = Duration.zero;
  Duration get _elapsedTime => _currentlyElapsed + _previouslyElapsed;

  @override
  void initState() {
    //create ticker
    _ticker = createTicker((elapsed) {
      setState(() {
        _currentlyElapsed = elapsed;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void toggleRunning(bool isRunning) {
    setState(() {
      if (isRunning) {
        _ticker.start();
      } else {
        _ticker.stop();
        _previouslyElapsed += _currentlyElapsed;
        _currentlyElapsed = Duration.zero;
      }
    });
  }

  void resetTimer() {
    _ticker.stop();
    setState(() {
      _currentlyElapsed = Duration.zero;
      _previouslyElapsed = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: widget.radius,
          top: widget.radius,
          child: ClockHand(
              rotationZAngle:
                  pi + (2 * pi / 60000) * _elapsedTime.inMilliseconds,
              handThickness: 2,
              handLength: widget.radius * 0.99,
              color: Colors.orange),
        ),
        Positioned(
            right: 0,
            left: 0,
            top: widget.radius * 1.4,
            child: ElapsedTimeText(elapsed: _elapsedTime)),
      ],
    );
  }
}
