import 'dart:convert';

import 'package:abricoz_app/src/data/models/order/delivery_time_entity.dart';
import 'package:abricoz_app/src/domain/entity/order/delivery_time_entity.dart';
import 'package:abricoz_app/src/domain/entity/order/order_entity.dart';
import 'package:abricoz_app/src/domain/entity/order/order_history_entity.dart';
import 'package:abricoz_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dio/dio.dart';

import '../../common/api.dart';
import '../../common/constants.dart';
import '../../core/error/exception.dart';
import '../../domain/entity/order/check_card_entity.dart';
import '../models/order/check_card_model.dart';
import '../models/order/order_history_model.dart';
import '../models/order/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<CheckCardEntity> checkBasketItems(MapParams params);

  Future<OrderEntity> createOrder(MapParams params);

  Future<List<DeliveryTimeEntity>> getDeliveryTime();

  Future<List<OrderHistoryEntity>> fetchOrderHistory();
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final API api;

  OrderRemoteDataSourceImpl(this.api);

  @override
  Future<CheckCardEntity> checkBasketItems(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${host}cart/check',
        data: params.data,
      );

      if (response.statusCode == 200) {
        return CheckCardModel.fromJson(response.data['data']);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<DeliveryTimeEntity>> getDeliveryTime() async {
    try {
      final response = await api.dio.get(
        '${host}delivery-interval/index',
      );

      if (response.statusCode == 200) {
        return (response.data['data']['delivery_intervals'] as List)
            .map((e) => DeliveryTimeModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<OrderEntity> createOrder(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${host}order/store',
        data: params.data,
      );

      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data['data']);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<OrderHistoryEntity>> fetchOrderHistory() async {
    try {
      final response = await api.dio.get(
        '${host}order/index',
      );

      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => OrderHistoryModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }
}
