import 'dart:convert';

import 'package:abricoz_app/src/domain/entity/user/banner_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/city_model.dart';
import 'package:abricoz_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dio/dio.dart';

import '../../common/api.dart';
import '../../common/constants.dart' as constants;
import '../../core/error/exception.dart';
import '../models/user/banner_model.dart';
import '../models/user/city_model.dart';

abstract class UserRemoteDataSource {
  Future<Map<String, dynamic>> signInPhone(MapParams params);

  Future<Map<String, dynamic>> signInCode(MapParams params);

  Future<List<CityEntity>> getCityList();

  Future<List<BannerEntity>> fetchBanners();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final API api;

  UserRemoteDataSourceImpl(this.api);

  @override
  Future<Map<String, dynamic>> signInPhone(MapParams params) async {
    try {
      final response =
          await api.dio.post('${constants.host}auth/code', data: params.data);
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
  Future<Map<String, dynamic>> signInCode(MapParams params) async {
    try {
      final response =
          await api.dio.post('${constants.host}auth/login', data: params.data);
      if (response.statusCode == 200) {
        int index = response.data.indexOf('{"data":');

        String jsonString = response.data.substring(index);
        return jsonDecode(jsonString);
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
}
