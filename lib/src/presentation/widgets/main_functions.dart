import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/app_styles/colors.dart';
import '../../common/constants.dart';

void launchUrlFunc(String link, {bool browser = false}) async {
  Uri uri = Uri.parse(link);
  await launchUrl(uri,
      mode: browser
          ? LaunchMode.externalApplication
          : LaunchMode.platformDefault);
}

String removeNonNumeric(String input) {
  return input.replaceAll(RegExp(r'[^0-9]'), '');
}

String getLocaleText(Map<String, String>? input) {
  String? locale = SharedPrefs().getLocaleLang();
  return input?[locale == 'kk' ? 'kz' : locale] ?? '';
}

String convertFilePathToUrl(String filePath) {
  return filePath.replaceFirst('/', host.replaceAll('api/', ''));
}

List<String> convertFilePathsToUrls(List<String> filePaths) {
  return filePaths.map((filePath) {
    return filePath.replaceFirst('/', host.replaceAll('api/', ''));
  }).toList();
}

Color? getColorByStatus(String key) {
  final data = {
    'all': AppColors.black,
    'new': AppColors.green,
    'accepted': AppColors.black,
    'in_progress': AppColors.mainBlue,
    'closed': AppColors.errorRedColor,
  };
  return data[key];
}
