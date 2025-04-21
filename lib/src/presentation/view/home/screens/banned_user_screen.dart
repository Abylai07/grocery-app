import 'dart:io';

import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/app_styles/colors.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/presentation/widgets/buttons/main_button.dart';
import 'package:abricoz_app/src/presentation/widgets/padding_nav_buttons.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/utils/l10n/generated/l10n.dart';

@RoutePage()
class BannedUserScreen extends StatelessWidget {
  const BannedUserScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double imageHeight = constraints.maxHeight - appBarHeight - kBottomNavigationBarHeight;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    S.of(context).account_blocked,
                    style: AppTextStyle.titleMedium
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: Text(
                      S.of(context).contact_admin,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyLarge
                          .copyWith(color: AppColors.textGray),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Image.asset(
                  AppAssets.upgradeApp,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
