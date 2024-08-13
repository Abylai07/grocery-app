import 'package:flutter/material.dart';

import '../../common/app_styles/colors.dart';

void showErrorSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: AppColors.errorRedColor,
    ),
  );
}