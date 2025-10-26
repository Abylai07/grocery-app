import 'dart:io';

import 'package:grocery_app/src/common/constants.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';

class AppsFlyerFunctions {
  static Future<void> initAppsFlyer() async {
    print('AppsFlyer init start');
    final AppsFlyerOptions appsFlyerOptions;
    final AppsflyerSdk appsflyerSdk;
    // AppsFlyer
    appsFlyerOptions = AppsFlyerOptions(
      afDevKey: devKey,
      appId: Platform.isAndroid ? "com.abricoz.app" : "6670238244", // Your app ID
      showDebug: true, // Display debug logs
      timeToWaitForATTUserAuthorization: 50, // Required for iOS 14.5+
    );
    appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
    appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );
    print('AppsFlyer init finished');
  }

  // static Future<void> logEvent(String eventName, Map eventValues) async {
  //   bool? result;
  //   try {
  //     result = await appsflyerSdk.logEvent(eventName, eventValues);
  //   } on Exception catch (e) {
  //     // Handle exception
  //   }
  //   print("Result logEvent: $result");
  // }
}
