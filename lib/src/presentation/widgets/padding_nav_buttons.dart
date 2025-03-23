import 'package:flutter/material.dart';

class PaddingForNavButtons extends StatelessWidget {
  const PaddingForNavButtons({
    super.key,
    required this.child,
    this.radius = 0,
  });
  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 4,
        right: 16,
        left: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 12,
      ),
      child: SafeArea(child: child),
    );
  }
}
