import 'package:flutter/material.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';

class RichTextInfoWidget extends StatelessWidget {
  const RichTextInfoWidget({
    super.key,
    required this.count,
    required this.name,
  });

  final num count;
  final String name;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$count\n',
            style: AppTextStyle.titleBold,
          ),
          TextSpan(
            text: name,
            style: AppTextStyle.bodyLarge.copyWith(color: AppColors.textGray),
          ),
        ],
      ),
    );
  }
}