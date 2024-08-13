import 'package:abricoz_app/src/application.dart';
import 'package:abricoz_app/src/data/hive/adapter/product_adapter.dart';
import 'package:abricoz_app/src/get_it_sl.dart' as sl;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';

Box? hiveBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  await GetStorage.init();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductHiveModelAdapter());
  hiveBox = await Hive.openBox('box');
  runApp(Application());
}
