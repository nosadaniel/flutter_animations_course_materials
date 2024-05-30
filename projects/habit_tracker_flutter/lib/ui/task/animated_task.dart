import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';

import '../common_widgets/centered_svg_icon.dart';
import '../theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask({super.key, required this.iconName});
  final String iconName;
  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _curveAnimation;
  bool _showCheckIcon = false;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    //initialize animation curves
    _curveAnimation = _animationController.drive(
      CurveTween(curve: Curves.easeInOut),
    );

    //initialize animation listener
    _animationController.addStatusListener(handleStatusListener);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController.removeStatusListener(handleStatusListener);
    super.dispose();
  }

  void handleStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (mounted) {
        setState(() => _showCheckIcon = true);
        //reset checkIcon to false after 1 sec delay
        Future.delayed(Duration(seconds: 1), () {
          if (mounted) {
            setState(() => _showCheckIcon = false);
          }
        });
      }
    }
  }

  void _handleTapUp(TapUpDetails pressUp) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  void _handleTapCancel() {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.forward();
    } //reset animation for testing
    else if (!_showCheckIcon) {
      _animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _handleTapUp,
      onTapDown: (_) => _handleTapCancel(),
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _curveAnimation,
        builder: (context, _) {
          final appTheme = AppTheme.of(context);
          final double progress = _curveAnimation.value;
          final hasCompleted = progress == 1.0;
          final iconColor =
              hasCompleted ? appTheme.accentNegative : appTheme.taskIcon;
          return Stack(
            children: [
              TaskCompletionRing(progress: progress),
              Positioned.fill(
                child: CenteredSvgIcon(
                    iconName: hasCompleted && _showCheckIcon
                        ? AppAssets.check
                        : widget.iconName,
                    color: iconColor),
              )
            ],
          );
        },
      ),
    );
  }
}
