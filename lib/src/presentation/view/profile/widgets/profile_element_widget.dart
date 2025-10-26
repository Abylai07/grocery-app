import 'package:grocery_app/src/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/shared_preference.dart';

class ProfileElementWidget extends StatelessWidget {
  const ProfileElementWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
    this.isLanguage = false,
    this.logout = false,
  });
  final String title;
  final bool isLanguage;
  final bool logout;
  final String icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        leading: SvgPicture.asset(
          icon,
          colorFilter: logout
              ? const ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)
              : null,
        ),
        title: Text(
          title,
          style: AppTextStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: logout ? AppColors.redColor : AppColors.black),
        ),
        trailing: logout
            ? const SizedBox()
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isLanguage)
                    Text(
                      getLanguageText(),
                      style: AppTextStyle.bodyMedium
                          .copyWith(color: AppColors.gray),
                    ),
                  6.width,
                  SvgPicture.asset(AppAssets.arrowNext),
                ],
              ),
      ),
    );
  }

  getLanguageText() {
    final localLan = SharedPrefs().getLocaleLang();
    switch (localLan) {
      case 'kk':
        return 'Қазақша';
      case 'ru':
        return 'Русский';
      case 'en':
        return 'English';
      default:
        return '';
    }
  }
}
