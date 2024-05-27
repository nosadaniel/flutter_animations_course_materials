import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stopwatch_flutter/ui/clock_hand.dart';
import 'package:stopwatch_flutter/ui/clock_markers.dart';

import 'elapsed_time_text.dart';

class StopWatchView extends StatelessWidget {
  const StopWatchView({super.key, required this.elapsed, required this.radius});
  final Duration elapsed;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Stack(
      //alignment: AlignmentDirectional.center,
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //     border: Border.all(width: 3, color: Colors.orange),
        //     borderRadius: BorderRadius.circular(radius),
        //   ),
        // ),
        for (var i = 0; i < 60; i++)
          Positioned(
            left: radius,
            top: radius,
            child: ClockSecondsTickMarker(seconds: i, radius: radius),
          ),
        for (var i = 5; i <= 60; i += 5)
          Positioned(
            left: radius,
            top: radius,
            child: ClockTextMarker(
              value: i,
              maxValue: 60,
              radius: radius,
            ),
          ),
        Positioned(
          left: radius,
          top: radius,
          child: ClockHand(
              rotationZAngle: pi + (2 * pi / 60000) * elapsed.inMilliseconds,
              handThickness: 2,
              handLength: radius * 0.99,
              color: Colors.orange),
        ),
        Positioned(
            right: 0,
            left: 0,
            top: radius * 1.4,
            child: ElapsedTimeText(elapsed: elapsed)),
      ],
    );
  }
}
