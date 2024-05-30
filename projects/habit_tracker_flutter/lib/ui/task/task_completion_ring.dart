import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskCompletionRing extends StatelessWidget {
  const TaskCompletionRing({super.key, required this.progress});

  ///progress range from 0 to 1
  final double progress;
  @override
  Widget build(BuildContext context) {
    final themeData = AppTheme.of(context);
    final completed = progress == 1.0;

    return AspectRatio(
      aspectRatio: 1.0,
      child: completed
          ? CompletedTask(
              taskCompletedColor: themeData.accent,
            )
          : CustomPaint(
              painter: _RingPainter(
                  progress: progress,
                  taskNotCompletedColor: themeData.taskRing,
                  taskCompletedColor: themeData.accent),
            ),
    );
  }
}

class CompletedTask extends StatelessWidget {
  const CompletedTask({super.key, required this.taskCompletedColor});
  final Color taskCompletedColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: taskCompletedColor),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color taskNotCompletedColor;
  final Color taskCompletedColor;

  const _RingPainter(
      {required this.progress,
      required this.taskNotCompletedColor,
      required this.taskCompletedColor});

  @override
  void paint(Canvas canvas, Size size) {
    final notCompleted = progress < 1.0;
    final strokeWidth = size.width / 15.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        notCompleted ? (size.width - strokeWidth) / 2 : size.width / 2;

    if (notCompleted) {
      final backgroundPaint = Paint()
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = taskNotCompletedColor
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(center, radius, backgroundPaint);
    }

    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskCompletedColor
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        2 * pi * progress, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
