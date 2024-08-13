import 'package:flutter/material.dart';

import '../../../common/app_styles/colors.dart';


class BorderContainer extends StatelessWidget {
  const BorderContainer(
      {super.key,
        required this.child,
        this.width,
        this.padding,
        this.margin,
        this.height,
        this.radius = 12,
        this.color});
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final Color? color;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: color ?? AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        padding:
        padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: margin,
        child: child);
  }
}