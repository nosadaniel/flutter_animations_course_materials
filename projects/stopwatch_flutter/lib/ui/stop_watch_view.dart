import 'package:flutter/material.dart';
import 'package:stopwatch_flutter/ui/clock_markers.dart';

class StopWatchView extends StatelessWidget {
  const StopWatchView({super.key, required this.radius});
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
      ],
    );
  }
}
