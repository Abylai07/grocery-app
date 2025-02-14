import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/app_styles/text_styles.dart';

showSnackBar(BuildContext context, String text,
    {String? image, Function()? onPressed}) {
  return InteractiveToast.slide(
    context,
    leading: SvgPicture.asset(
      image ?? AppAssets.success,
      height: 40,
      width: 40,
    ),
    title: Text(
      text,
      style: AppTextStyle.bodyMedium,
    ),
    onTapped: onPressed,
    toastStyle: const ToastStyle(
        titleLeadingGap: 10,
        padding: EdgeInsets.all(10),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        )),
    toastSetting: const SlidingToastSetting(
      animationDuration: Duration(seconds: 1),
      displayDuration: Duration(seconds: 2),
      toastStartPosition: ToastPosition.top,
      toastAlignment: Alignment.topCenter,
      progressBarHeight: 4,
      maxHeight: 48,
      padding: EdgeInsets.symmetric(horizontal: 24),
      maxWidth: double.infinity,
    ),
  );
}
