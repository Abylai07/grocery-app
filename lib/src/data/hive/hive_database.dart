import 'dart:developer';

import 'package:abricoz_app/src/data/hive/adapter/product_adapter.dart';

import '../../../../main.dart';
import '../models/product/product_model.dart';

class BasketDatabase {
  BasketDatabase._privateConstructor();

  static final BasketDatabase _instance = BasketDatabase._privateConstructor();

  factory BasketDatabase() {
    return _instance;
  }

  List<ProductHiveModel> getAllProducts() {
    return hiveBox?.values.cast<ProductHiveModel>().toList() ?? [];
  }

  Future<void> deleteProduct(String? key) async {
    if (key == null) return;
    hiveBox?.delete(key);
  }

  Future<void> changeProductCount(String key, int count) async {
    ProductHiveModel? product = hiveBox?.get(key);
    if(product == null) return;
    await hiveBox?.put(key, product.copyWith(basketCount: count));
    log('changeProductCount call success : key $key');
  }

  Future<void> addProductFromEntity(ProductModel product) async {
    ProductHiveModel model = ProductHiveModel.fromJson(product.toJson());
    await hiveBox?.put(model.id.toString(), model);
    log('addProductFromEntity call success : key ${model.id}');
  }

  // Future<void> addProductFromEntity(ProductModel product, int count) async {
  //   ProductHiveModel model = ProductHiveModel.fromJson(product.toJson());
  //   if(hiveBox?.containsKey(model.id) == true){
  //     ProductHiveModel? currentModel = hiveBox?.get(model.id);
  //     await hiveBox?.put(model.id, currentModel?.copyWith(basketCount: count));
  //   } else {
  //     await hiveBox?.put(model.id, model);
  //   }
  // }

  Future<void> addProduct(ProductHiveModel product) async {
    await hiveBox?.add(product);
  }

  Future<void> clearBasket() async => hiveBox?.clear();

}
