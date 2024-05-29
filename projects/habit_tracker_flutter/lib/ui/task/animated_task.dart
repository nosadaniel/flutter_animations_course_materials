import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask({super.key, required this.progress});
  final double progress;
  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _curveAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    _curveAnimation = _animationController.drive(
      CurveTween(curve: Curves.easeInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapUp(TapUpDetails pressUp) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails pressDown) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.forward();
    } else {
      //for testing
      _animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _handleTapUp,
      onTapDown: _handleTapDown,
      child: AnimatedBuilder(
          animation: _curveAnimation,
          builder: (context, _) =>
              TaskCompletionRing(progress: _curveAnimation.value)),
    );
  }
}
