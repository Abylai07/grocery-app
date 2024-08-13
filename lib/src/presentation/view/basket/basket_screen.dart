import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/utils/l10n/generated/l10n.dart';

@RoutePage()
class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).basket),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42.0),
              child: Image.asset(AppAssets.basketEmpty),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 12),
              child: Text(
                S.of(context).basketEmpty,
                style: AppTextStyle.titleMedium
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              S.of(context).hereWillProduct,
              style: AppTextStyle.bodyLarge.copyWith(color: AppColors.textGray),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
