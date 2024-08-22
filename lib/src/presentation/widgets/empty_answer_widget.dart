import 'package:flutter/material.dart';

import '../../common/app_styles/assets.dart';
import '../../common/app_styles/colors.dart';
import '../../common/app_styles/text_styles.dart';
import '../../common/utils/l10n/generated/l10n.dart';

class EmptyAnswerWidget extends StatelessWidget {
  const EmptyAnswerWidget({
    super.key,
    this.description,
  });
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 56.0),
          child: Image.asset(AppAssets.searchEmpty),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 12),
          child: Text(
            S.of(context).notFound,
            style:
            AppTextStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          description ?? S.of(context).againOtherWord,
          style: AppTextStyle.bodyLarge.copyWith(color: AppColors.textGray),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
