import 'package:abricoz_app/src/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../common/utils/locale/locale.dart';
import '../../../../common/utils/shared_preference.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localLan = SharedPrefs().getLocaleLang();
    changeLanguage(String lan) {
      if (lan == localLan) return;
      SharedPrefs().setLocaleLang(lan);

      LocaleBuilder.setLocale(context, Locale(lan));
    }

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).appLanguage,
                    style: AppTextStyle.titleBold,
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.textGray,
                    ),
                  )
                ],
              ),
              24.height,
              InkWell(
                onTap: () {
                  changeLanguage('kk');
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Қазақша',
                        style: AppTextStyle.bodyLarge,
                      ),
                    ),
                    if(localLan == 'kk')
                    SvgPicture.asset(AppAssets.selected),
                  ],
                ),
              ),
              const Divider(
                height: 32,
                color: AppColors.grayContainer,
              ),
              InkWell(
                onTap: () {
                  changeLanguage('ru');
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Русский',
                        style: AppTextStyle.bodyLarge,
                      ),
                    ),
                    if(localLan == 'ru')
                      SvgPicture.asset(AppAssets.selected),
                  ],
                ),
              ),
              const Divider(
                height: 32,
                color: AppColors.grayContainer,
              ),
              InkWell(
                onTap: () {
                  changeLanguage('en');
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'English',
                        style: AppTextStyle.bodyLarge,
                      ),
                    ),
                    if(localLan == 'en')
                      SvgPicture.asset(AppAssets.selected),
                  ],
                ),
              ),
              const Divider(
                height: 32,
                color: AppColors.grayContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
