import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppTextStyle {
    static const fontFamily = 'Inter';

  static final biglineLarge = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 32.spMin,
    fontFamily: fontFamily,
    color: AppColors.black,
  );

  static final appBarStyle = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 20.spMin, fontFamily: fontFamily);

  static final headlineSmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 24.spMin,
    fontFamily: fontFamily,
    color: AppColors.black,
  );
  static final headlineLarge = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 28.spMin,
    fontFamily: fontFamily,
    color: AppColors.black,
  );

  static final titleLarge = TextStyle(
      color: AppColors.black,
      fontSize: 22.spMin,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily);
  static final titleMedium = TextStyle(
      color: AppColors.black,
      fontSize: 20.spMin,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily);
    static final titleBold = TextStyle(
      fontSize: 18.spMin,
      color: AppColors.black,
      fontWeight: FontWeight.w700,
      fontFamily: fontFamily,
    );
  static final titleSmall = TextStyle(
    fontSize: 18.spMin,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static final bodyLarge = TextStyle(
      fontSize: 16.spMin,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      fontFamily: fontFamily);
    static final bodyMedium = TextStyle(
      fontSize: 15.spMin,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      fontFamily: fontFamily);
  static final bodySmall = TextStyle(
      fontSize: 14.spMin,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
      fontFamily: fontFamily);

  static final labelLarge = TextStyle(
      fontSize: 16.spMin,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
      fontFamily: fontFamily);
  static final labelMedium = TextStyle(
      fontSize: 14.spMin,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      fontFamily: fontFamily);
  static final labelSmall = TextStyle(
      fontSize: 12.spMin,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
      fontFamily: fontFamily);

  static final displayLarge = TextStyle(
      fontSize: 14.spMin,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
      fontFamily: fontFamily);
  static final displayMedium = TextStyle(
      fontSize: 12.spMin,
      fontWeight: FontWeight.w300,
      color: AppColors.black,
      fontFamily: fontFamily);
  static final displaySmall = TextStyle(
      fontSize: 10.spMin,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
      fontFamily: fontFamily);
}
