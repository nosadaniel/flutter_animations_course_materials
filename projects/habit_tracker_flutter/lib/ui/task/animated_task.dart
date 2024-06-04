import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';

import '../common_widgets/centered_svg_icon.dart';
import '../theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask(
      {super.key,
      required this.iconName,
      required this.completed,
      this.onCompleted});
  final String iconName;
  final bool completed;
  final ValueChanged<bool>? onCompleted;
  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _curveAnimation;
  //for showing checkmark
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
    _animationController.addStatusListener(handleStatusUpdateListener);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController.removeStatusListener(handleStatusUpdateListener);
    super.dispose();
  }

  void handleStatusUpdateListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      //set onCompleted callable to true
      //call () for calling nullable callback
      widget.onCompleted?.call(true);
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

  void _handleTapCancel() {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails pressUp) {
    if (!widget.completed &&
        _animationController.status != AnimationStatus.completed) {
      _animationController.forward();
    } //reset animation for testing
    // else if (!_showCheckIcon) {
    //   _animationController.reset();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) => _handleTapCancel(),
      onTapDown: _handleTapDown,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _curveAnimation,
        builder: (context, _) {
          final appTheme = AppTheme.of(context);
          final double progress =
              widget.completed ? 1.0 : _curveAnimation.value;
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
