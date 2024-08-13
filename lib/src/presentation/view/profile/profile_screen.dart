import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/utils/l10n/generated/l10n.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(S.of(context).profile),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.settings),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ProfileElementWidget(
                    title: S.of(context).loginAccount,
                    icon: AppAssets.account,
                    onPressed: () {
                      context.router.push(const SignInRoute());
                    },
                  ),
                  ProfileElementWidget(
                    title: S.of(context).logout,
                    icon: AppAssets.logout,
                    logout: true,
                    onPressed: () {
                      SharedPrefs().deleteTokens();
                      context.router.replaceAll([
                        const IndexRoute(children: [HomeRoute()])
                      ]);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ProfileElementWidget(
                    title: S.of(context).address,
                    icon: AppAssets.address,
                    onPressed: () {
                      // context.router.push(const SignInRoute());
                    },
                  ),
                  ProfileElementWidget(
                    title: S.of(context).carts,
                    icon: AppAssets.cards,
                    onPressed: () {
                      //  context.router.push(const SignInRoute());
                    },
                  ),
                  ProfileElementWidget(
                    title: S.of(context).orders,
                    icon: AppAssets.orders,
                    onPressed: () {
                      //context.router.push(const SignInRoute());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileElementWidget extends StatelessWidget {
  const ProfileElementWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
    this.logout = false,
  });
  final String title;
  final bool logout;
  final String icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        leading: SvgPicture.asset(icon),
        title: Text(
          title,
          style: AppTextStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: logout ? AppColors.redColor : AppColors.black),
        ),
        trailing:
            logout ? const SizedBox() : SvgPicture.asset(AppAssets.arrowNext),
      ),
    );
  }
}
