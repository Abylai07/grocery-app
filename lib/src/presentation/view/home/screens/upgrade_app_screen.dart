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
class UpgradeAppScreen extends StatelessWidget {
  const UpgradeAppScreen({super.key, required this.storeUrl});

  final String storeUrl;

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;

    void sendUserToAppStore() async {
      if (storeUrl.isEmpty) {
        print('upgrader: empty appStoreListingURL');
        return;
      }

      print('upgrader: launching: $storeUrl');

      if (await canLaunchUrl(Uri.parse(storeUrl))) {
        try {
          await launchUrl(Uri.parse(storeUrl),
              mode: Platform.isAndroid
                  ? LaunchMode.externalNonBrowserApplication
                  : LaunchMode.platformDefault);
        } catch (e) {
          print('upgrader: launch to app store failed: $e');
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: PaddingForNavButtons(
        child: CustomMainButton(
          height: 52,
          text: S.of(context).update_button,
          onTap: sendUserToAppStore,
        ),
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
                    S.of(context).update_available,
                    style: AppTextStyle.titleMedium
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: Text(
                      S.of(context).update_message,
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
