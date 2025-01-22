import 'package:abricoz_app/src/application.dart';
import 'package:abricoz_app/src/common/utils/appsflyer_functions.dart';
import 'package:abricoz_app/src/data/hive/hive_database.dart';
import 'package:abricoz_app/src/get_it_sl.dart' as sl;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';

import 'firebase_options.dart';

Box? hiveBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppsFlyerFunctions.initAppsFlyer();
  await sl.init();
  await GetStorage.init();
  BasketDatabase().initHive();
  await Firebase.initializeApp(
    name: 'Abricoz-App',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if(kReleaseMode){
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const Application());
  });
}

