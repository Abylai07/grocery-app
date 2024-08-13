import 'package:flutter/material.dart';

import '../../common/app_styles/colors.dart';
import '../../common/app_styles/text_styles.dart';

class AppSnackBarWidget extends StatelessWidget {
  const AppSnackBarWidget({
    super.key,
    required this.description,
    this.color = AppColors.green,
    this.onPressed,
  });

  final String? description;
  final VoidCallback? onPressed;
  final Color color;

  Future<void> show(
      BuildContext context,
      ) async {
    showTopSnackBar(
      context,
      this,
      onTap: onPressed ?? (){},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Text(
          '$description',
          maxLines: 2,
          style: AppTextStyle.labelMedium.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}



OverlayEntry? _previousEntry;

void showTopSnackBar(
    BuildContext context,
    Widget child, {
      Duration showOutAnimationDuration = const Duration(milliseconds: 350),
      Duration hideOutAnimationDuration = const Duration(milliseconds: 550),
      Duration displayDuration = const Duration(milliseconds: 3000),
      double additionalTopPadding = 24.0,
      VoidCallback? onTap,
      OverlayState? overlayState,
      double leftPadding = 16,
      double rightPadding = 16,
    }) async {
  overlayState ??= Overlay.of(context);
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) {
      return TopSnackBar(
        onDismissed: () {
          overlayEntry.remove();
          _previousEntry = null;
        },
        showOutAnimationDuration: showOutAnimationDuration,
        hideOutAnimationDuration: hideOutAnimationDuration,
        displayDuration: displayDuration,
        additionalTopPadding: additionalTopPadding,
        onTap: onTap,
        leftPadding: leftPadding,
        rightPadding: rightPadding,
        child: child,
      );
    },
  );

  _previousEntry?.remove();
  overlayState.insert(overlayEntry);
  _previousEntry = overlayEntry;
}

/// Widget that controls all animations
class TopSnackBar extends StatefulWidget {
  const TopSnackBar({
    Key? key,
    required this.child,
    required this.onDismissed,
    required this.showOutAnimationDuration,
    required this.hideOutAnimationDuration,
    required this.displayDuration,
    required this.additionalTopPadding,
    this.onTap,
    this.leftPadding = 16,
    this.rightPadding = 16,
  }) : super(key: key);

  final double additionalTopPadding;
  final Widget child;
  final Duration displayDuration;
  final Duration hideOutAnimationDuration;
  final double leftPadding;
  final VoidCallback onDismissed;
  final VoidCallback? onTap;
  final double rightPadding;
  final Duration showOutAnimationDuration;

  @override
  _TopSnackBarState createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<TopSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation offsetAnimation;
  double? topPosition;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    topPosition = widget.additionalTopPadding;
    _setupAndStartAnimation();
    super.initState();
  }

  void _setupAndStartAnimation() async {
    animationController = AnimationController(
      vsync: this,
      duration: widget.showOutAnimationDuration,
      reverseDuration: widget.hideOutAnimationDuration,
    );

    Tween<Offset> offsetTween = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    );

    offsetAnimation = offsetTween.animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutCirc,
        reverseCurve: Curves.linearToEaseOut,
      ),
    )..addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(widget.displayDuration);
        if (mounted) {
          animationController.reverse();
          setState(() {
            topPosition = 0;
          });
        }
      }

      if (status == AnimationStatus.dismissed) {
        widget.onDismissed.call();
      }
    });

    if (mounted) {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: widget.hideOutAnimationDuration * 1.5,
      curve: Curves.linearToEaseOut,
      top: topPosition,
      left: widget.leftPadding,
      right: widget.rightPadding,
      child: SlideTransition(
        position: offsetAnimation as Animation<Offset>,
        child: SafeArea(
          child: TapBounceContainer(
            onTap: () {
              if (mounted) {
                widget.onTap?.call();
                animationController.reverse();
              }
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }
}


/// Widget for nice tap effect. It decrease widget scale while tapping
class TapBounceContainer extends StatefulWidget {
  const TapBounceContainer({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;

  @override
  _TapBounceContainerState createState() => _TapBounceContainerState();
}

class _TapBounceContainerState extends State<TapBounceContainer>
    with SingleTickerProviderStateMixin {
  final animationDuration = const Duration(milliseconds: 200);

  late AnimationController _controller;
  late double _scale;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: animationDuration,
      lowerBound: 0.0,
      upperBound: 0.04,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void _onTapDown(TapDownDetails details) {
    if (mounted) {
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) async {
    await _closeSnackBar();
  }

  void _onPanEnd(DragEndDetails details) async {
    await _closeSnackBar();
  }

  Future _closeSnackBar() async {
    if (mounted) {
      _controller.reverse();
      await Future.delayed(animationDuration);
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onPanEnd: _onPanEnd,
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}



