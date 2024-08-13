import 'package:abricoz_app/src/domain/entity/product/category_entity.dart';
import 'package:abricoz_app/src/domain/entity/product/product_entity.dart';
import 'package:abricoz_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dio/dio.dart';

import '../../common/api.dart';
import '../../common/constants.dart' as constants;
import '../../core/error/exception.dart';
import '../../domain/entity/product/search_hint_entity.dart';
import '../../domain/entity/product/sub_category_entity.dart';
import '../../domain/usecase/product/category_usecase.dart';
import '../models/product/category_model.dart';
import '../models/product/product_model.dart';
import '../models/product/search_hint_model.dart';
import '../models/product/sub_category_model.dart';

abstract class ProductRemoteDataSource {

  Future<List<CategoryEntity>> fetchCategory(MapParams params);

  Future<List<SubCategoryEntity>> fetchSubCategory(MapParams params);

  Future<List<ProductEntity>> fetchProducts(MapParams params);

  Future<List<SearchHintEntity>> fetchSearchHint(MapParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final API api;

  ProductRemoteDataSourceImpl(this.api);


  @override
  Future<List<CategoryEntity>> fetchCategory(MapParams params) async {
    try {
      final response = await api.dio.get(
        '${constants.host}category/index',
      );

      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<SubCategoryEntity>> fetchSubCategory(MapParams params) async {
    try {
      final response = await api.dio.get(
        '${constants.host}sub-category/index',
      );

      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => SubCategoryModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<ProductEntity>> fetchProducts(MapParams params) async {
    try {
      final response = await api.dio.get(
        '${constants.host}product/index',
        queryParameters: params.data
      );

      if (response.statusCode == 200) {
        return (response.data['data']['products'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<SearchHintEntity>> fetchSearchHint(MapParams params) async {
    try {
      final response = await api.dio.get(
          '${constants.host}product/search',
          queryParameters: params.data
      );

      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => SearchHintModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }
}
