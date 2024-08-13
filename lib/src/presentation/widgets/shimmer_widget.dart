import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/app_styles/colors.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {super.key,
        required this.width,
        required this.height,
        this.isCircle = false});
  final double width;
  final double height;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: AppColors.white,
        highlightColor: AppColors.shimmer,
        enabled: true,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: isCircle ? null : BorderRadius.circular(12),
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          ),
        ),
      ),
    );
  }
}