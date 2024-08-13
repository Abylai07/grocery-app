import 'package:flutter/material.dart';

import '../../../common/app_styles/colors.dart';

class PointContainer extends StatelessWidget {
  const PointContainer({
    super.key, required this.value,
  });
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.mainBlue, width: 1.0),
      ),
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value ? AppColors.mainBlue : Colors.transparent, // Inner circular point color
          ),
          child: const SizedBox(
            width: 14,
            height: 14,
          ),
        ),
      ),
    );
  }
}
