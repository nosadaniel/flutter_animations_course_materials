import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';

import '../common_widgets/centered_svg_icon.dart';
import '../theming/app_theme.dart';

///[iconName] takes the first letter of the iconName if icon not found.
///[completed] indicate that animation is 1.0 .
///[onCompleted] is called inside [_handleStatusUpdateListener] when status is completed.
///[isEditing] by default is false, use to indicate if task is being edited
///[hasCompletedState] by default is true, use to indicate that animation has completed
/// and used to indicate when to reset animationController in the [_handleStatusUpdateListener] callback
class AnimatedTask extends StatefulWidget {
  const AnimatedTask(
      {super.key,
      required this.iconName,
      required this.completed,
      this.onCompleted,
      this.isEditing = false,
      this.hasCompletedState = true});
  final String iconName;
  final bool completed;
  final ValueChanged<bool>? onCompleted;
  final bool isEditing;
  final bool hasCompletedState;
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
    _animationController.addStatusListener(_handleStatusUpdateListener);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController.removeStatusListener(_handleStatusUpdateListener);
    super.dispose();
  }

  void _handleStatusUpdateListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      //call onCompleted and set to true when animation status is completed
      //call () for calling nullable callback
      widget.onCompleted?.call(true);
      if (widget.hasCompletedState) {
        if (mounted) {
          // show the checkIcon
          setState(() => _showCheckIcon = true);
        }
        //reset checkIcon to false after 1 sec delay
        // then hide the checkIcon
        Future.delayed(Duration(seconds: 1), () {
          if (mounted) {
            setState(() => _showCheckIcon = false);
          }
        });
      } else {
        _animationController.reset();
      }
    }
  }

  void _handleTapCancel() {
    if (!widget.isEditing &&
        _animationController.status != AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails pressUp) {
    if (!widget.isEditing &&
        !widget.completed &&
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
