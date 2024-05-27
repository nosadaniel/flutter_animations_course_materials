import 'dart:math';

import 'package:flutter/material.dart';

class ClockSecondsTickMarker extends StatelessWidget {
  const ClockSecondsTickMarker(
      {super.key, required this.seconds, required this.radius});
  final int seconds;
  final double radius;
  @override
  Widget build(BuildContext context) {
    final color = seconds % 5 == 0 ? Colors.white : Colors.grey[700];
    const width = 2.0;
    const height = 12.0;
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          //centralize
          ..translate(-width / 2, -height / 2, 0.0)
          //create multiple marker in circles
          ..rotateZ(2 * pi * (seconds / 60.0))
          //push the mark out
          ..translate(0.0, radius - height / 2, 0.0),
        child: Container(width: width, height: height, color: color));
  }
}

class ClockTextMarker extends StatelessWidget {
  const ClockTextMarker(
      {super.key,
      required this.value,
      required this.maxValue,
      required this.radius});
  final int value;
  final int maxValue;
  final double radius;
  @override
  Widget build(BuildContext context) {
    const width = 40.0;
    const height = 30.0;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        //centering the text
        ..translate(-width / 2, -height / 2, 0.0)
        // rotate text to 180 degree
        ..rotateZ(pi + 2 * pi * (value / maxValue))
        //push away fro the center
        ..translate(0.0, radius - 35, 0.0)
        // undo rotation
        ..rotateZ(pi - 2 * pi * (value / maxValue)),
      child: SizedBox(
        width: width,
        height: height,
        child: Text(
          value.toString(),
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
