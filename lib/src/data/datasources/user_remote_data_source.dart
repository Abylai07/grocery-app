import 'dart:convert';

import 'package:abricoz_app/src/domain/entity/user/address_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/banner_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/city_model.dart';
import 'package:abricoz_app/src/domain/entity/user/location_entity.dart';
import 'package:abricoz_app/src/domain/usecase/product/product_usecase.dart';
import 'package:abricoz_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dio/dio.dart';

import '../../common/api.dart';
import '../../common/constants.dart' as constants;
import '../../common/constants.dart';
import '../../common/utils/shared_preference.dart';
import '../../core/error/exception.dart';
import '../../domain/entity/product/product_entity.dart';
import '../../domain/entity/user/card_entity.dart';
import '../../domain/entity/user/user_entity.dart';
import '../../domain/usecase/product/category_usecase.dart';
import '../models/product/product_model.dart';
import '../models/user/address_model.dart';
import '../models/user/banner_model.dart';
import '../models/user/card_model.dart';
import '../models/user/city_model.dart';
import '../models/user/location_model.dart';
import '../models/user/user_model.dart';

abstract class UserRemoteDataSource {
  Future<Map<String, dynamic>> signInPhone(MapParams params);

  Future<UserEntity> signInCode(MapParams params);

  Future<UserEntity> setName(MapParams params);

  Future<List<CityEntity>> getCityList();

  Future<List<LocationEntity>> getCityPolygon(PathParams params);

  Future<List<BannerEntity>> fetchBanners();

  Future<List<AddressEntity>> fetchAddress();

  Future<Map<String, dynamic>> deleteAddress(PathParams params);

  Future<AddressEntity> createAddress(PathMapParams params);

  Future<ProductEntity> storeFavorite(MapParams params);

  Future<List<ProductEntity>> fetchFavorites();

  Future<Map<String, dynamic>> deleteFavorite(PathParams params);

  Future<bool> deleteUser();

  Future<bool> deleteCard(PathParams params);

  Future<List<CardEntity>> fetchMyCards();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final API api;

  UserRemoteDataSourceImpl(this.api);

  @override
  Future<Map<String, dynamic>> signInPhone(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}auth/code',
        data: params.data,
        options: Options(
          extra: {
            'skipAuth': true,
          },
        ),
      );
      if (response.statusCode == 200) {
        return {};
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<UserEntity> signInCode(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}auth/login',
        data: params.data,
        options: Options(
          extra: {
            'skipAuth': true,
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = response.data is Map
            ? response.data
            : deleteNotNeedPart(response.data);
        SharedPrefs().setAccessToken(result['data']['token']);
        return UserModel.fromJson(result['data']['user']);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<UserEntity> setName(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${host}auth/set-name',
        data: params.data,
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['data']['user']);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<CityEntity>> getCityList() async {
    try {
      final response = await api.dio.get(
        '${constants.host}city/index',
      );
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => CityModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<BannerEntity>> fetchBanners() async {
    try {
      final response = await api.dio.get(
        '${constants.host}mobile-banner/index',
        options: Options(
          extra: {
            'skipAuth': true,
          },
        ),
      );
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => BannerModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<AddressEntity> createAddress(PathMapParams params) async {
    try {
      final response = await api.dio
          .post('${constants.host}address/${params.path}', data: params.data);
      if (response.statusCode == 200) {
        return AddressModel.fromJson(response.data['data']['address']);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<AddressEntity>> fetchAddress() async {
    try {
      final response = await api.dio.get(
        '${constants.host}address/index',
      );
      if (response.statusCode == 200) {
        return (response.data['data']['addresses'] as List)
            .map((e) => AddressModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<ProductEntity>> fetchFavorites() async {
    try {
      final response = await api.dio.get(
        '${constants.host}favorite-product/index',
      );
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => ProductModel.fromJson(e['product']))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<ProductEntity> storeFavorite(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${host}favorite-product/store',
        data: params.data,
      );
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data['data']['product']);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> deleteFavorite(PathParams params) async {
    try {
      final response = await api.dio.delete(
        '${host}favorite-product/delete/${params.path}',
      );
      if (response.statusCode == 200) {
        return {};
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> deleteAddress(PathParams params) async {
    try {
      final response = await api.dio.delete(
        '${host}address/delete/${params.path}',
      );
      if (response.statusCode == 200) {
        return {};
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<bool> deleteUser() async {
    try {
      final response = await api.dio.delete(
        '${host}user/delete',
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<LocationEntity>> getCityPolygon(PathParams params) async {
    try {
      final response = await api.dio.get(
        '${constants.host}point/index?city_id=${params.path}',
      );
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => LocationModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<bool> deleteCard(PathParams params) async {
    try {
      final response = await api.dio.delete(
        '${host}order/user-card/delete/${params.path}',
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<CardEntity>> fetchMyCards() async {
    try {
      final response = await api.dio.get(
        '${host}user-card/index',
      );

      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => CardModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }
}


Map<String, dynamic> deleteNotNeedPart(String result) {
  int index = result.indexOf('{"data":');
  if (index != -1) {
    String remainingJsonString = result.substring(index);
    return jsonDecode(remainingJsonString);
  } else {
    return jsonDecode(result);
  }
}