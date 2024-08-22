import 'package:flutter/material.dart';

class PaddingForNavButtons extends StatelessWidget {
  const PaddingForNavButtons({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 6,
          right: 16,
          left: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 12),
      child: SafeArea(child: child),
    );
  }
}