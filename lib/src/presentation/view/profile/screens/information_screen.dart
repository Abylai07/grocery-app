import 'package:abricoz_app/src/common/app_styles/colors.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:abricoz_app/src/presentation/widgets/main_functions.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/constants.dart';
import '../../../../common/utils/app_router/app_router.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';

@RoutePage()
class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).info,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                context.router.push(WebViewRoute(
                  title: S.of(context).privacyPolicy,
                  url: privacyPolicy,
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).privacyPol,
                      style: AppTextStyle.bodyLarge,
                    ),
                    SvgPicture.asset(AppAssets.arrowNext),
                  ],
                ),
              ),
            ),
            const Divider(
              color: AppColors.divider,
              height: 16,
            ),
            InkWell(
              onTap: () {
                context.router.push(WebViewRoute(
                  title: S.of(context).public_offer,
                  url: publicOffer,
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).public_offer,
                      style: AppTextStyle.bodyLarge,
                    ),
                    SvgPicture.asset(AppAssets.arrowNext),
                  ],
                ),
              ),
            ),
            const Divider(
              color: AppColors.divider,
              height: 16,
            ),
            InkWell(
              onTap: () {
                context.router.push(WebViewRoute(
                  title: S.of(context).consent_to_personal_data_processing,
                  url: consentData,
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).consent_to_personal_data_processing,
                      style: AppTextStyle.bodyLarge,
                    ),
                    SvgPicture.asset(AppAssets.arrowNext),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
