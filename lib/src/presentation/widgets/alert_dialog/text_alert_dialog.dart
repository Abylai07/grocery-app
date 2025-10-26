import 'package:grocery_app/src/common/app_styles/assets.dart';
import 'package:grocery_app/src/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/app_styles/text_styles.dart';
import '../../../common/utils/l10n/generated/l10n.dart';

void confirmAlertDialog(BuildContext context,
    {required String title, Function()? onYesTap, String? buttonText}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.white,
        contentPadding:
            EdgeInsets.only(top: 24.h, bottom: 12.h, left: 16, right: 16),
        actionsPadding: const EdgeInsets.all(16),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppAssets.warning),
              16.height,
              Text(
                title,
                style: AppTextStyle.titleSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onYesTap,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.main,
                    ),
                    child: Text(
                      buttonText ?? S.of(context).confirm,
                      style: AppTextStyle.bodyLarge
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ),
              10.width,
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.lightGrey,
                    ),
                    child: Text(
                      S.of(context).cancel,
                      style: AppTextStyle.bodyLarge
                          .copyWith(color: AppColors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
