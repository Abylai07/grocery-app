import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/constants.dart';
import '../../domain/entity/order/order_history_entity.dart';

void launchUrlFunc(String link, {bool browser = false}) async {
  Uri uri = Uri.parse(link);
  await launchUrl(uri,
      mode: browser
          ? LaunchMode.externalApplication
          : LaunchMode.platformDefault);
}

String getLocaleText(Map<String, String>? input) {
  String? locale = SharedPrefs().getLocaleLang();
  return input?[locale == 'kk' ? 'kz' : locale] ?? '';
}

String convertFilePathToUrl(String? filePath) {
  if(filePath == null) {
    return '';
  } else if(filePath.contains('https')) {
    return filePath;
  }
  return filePath.replaceFirst('/', host.replaceAll('api/', ''));
}

List<String> convertFilePathsToUrls(List<String> filePaths) {
  return filePaths.map((filePath) {
    if(filePath.contains('https')) {
      return filePath;
    }
    return filePath.replaceFirst('/', host.replaceAll('api/', ''));
  }).toList();
}

String getServerDate(DateTime? dateTime) {

  DateFormat formatter = DateFormat("yyyy-MM-dd");
  String formattedDate = formatter.format(dateTime ?? DateTime.now());

  return formattedDate;
}

String formatDate(DateTime dateTime) {
  String locale = SharedPrefs().getLocaleLang();
  DateFormat formatter = DateFormat("d MMMM y 'г.'", locale);
  String formattedDate = formatter.format(dateTime);

  return formattedDate;
}

bool canCancelOrder(OrderHistoryEntity order) {
  return order.orderStatus.id == 1 && order.paymentTypeId == 1;
}

bool isDiscountFunc(num? discount, price){
  return discount != null && discount > 0 && discount < price;
}
