import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      dividerColor: AppColors.divider,
      brightness: Brightness.light,
      primaryColor: AppColors.main,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        // toolbarHeight: 87.h,
        toolbarTextStyle: TextStyle(
          fontSize: 16,
          height: 1.4,
          color: AppColors.black,
        ),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.4,
          fontFamily: 'Inter',
          color: AppColors.black,
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
          size: 20,
        ),
      ),
      bottomAppBarTheme: const BottomAppBarThemeData(
        elevation: 24,
        color: AppColors.gray1,
        shape: CircularNotchedRectangle(),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: AppColors.white),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
      ),
      primaryTextTheme: const TextTheme(
        bodyMedium: TextStyle(height: 1.4),
      ).apply(
        fontFamily: 'Inter',
        displayColor: AppColors.black,
        bodyColor: AppColors.black,
        decorationColor: AppColors.black,
      ),
      unselectedWidgetColor: AppColors.gray,
      fontFamily: 'Inter',
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        foregroundColor: AppColors.main,
        padding: EdgeInsets.zero,
        minimumSize: const Size(30, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: const TextStyle(
            color: AppColors.main,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.2),
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.main,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Replace SmoothRectangleBorder
              ),
              elevation: 0,
              minimumSize: const Size(double.infinity, 48),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 16, height: 1.2))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.main,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Replace SmoothRectangleBorder
              ),
              elevation: 0,
              side: const BorderSide(color: AppColors.main, width: 1.2),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.2,
              ))),
      colorScheme: const ColorScheme.light(
          primary: AppColors.main, surface: AppColors.white));
}
