import 'package:abricoz_app/src/data/models/order/delivery_time_entity.dart';
import 'package:abricoz_app/src/domain/entity/order/delivery_time_entity.dart';
import 'package:abricoz_app/src/domain/entity/order/order_history_entity.dart';
import 'package:abricoz_app/src/domain/entity/product/pagination_entity.dart';
import 'package:abricoz_app/src/domain/usecase/order/payment_use_case.dart';
import 'package:abricoz_app/src/domain/usecase/product/product_usecase.dart';
import 'package:abricoz_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dio/dio.dart';

import '../../common/api.dart';
import '../../common/constants.dart';
import '../../core/error/exception.dart';
import '../../domain/entity/order/check_card_entity.dart';
import '../models/order/check_card_model.dart';
import '../models/order/order_history_model.dart';
import '../models/order/order_model.dart';
import '../models/user/card_model.dart';

abstract class OrderRemoteDataSource {
  Future<CheckCardEntity> checkBasketItems(MapParams params);

  Future<int> createOrder(MapParams params);

  Future<List<DeliveryTimeEntity>> getDeliveryTime();

  Future<OrderPaginationEntity> fetchOrderHistory(MapParams params);

  Future<List<OrderHistoryEntity>> fetchActiveOrders();

  Future<OrderHistoryEntity> fetchOrderById(PathParams params);

  Future<bool> cancelOrder(PathParams params);

  Future<num> getMinPrice();

  Future<String> getPaymentLink(PaymentParams params);
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
        final deliveryIntervals = response.data['data']['delivery_intervals'] as Map<String, dynamic>;

        // Explicitly map and cast to the correct type
        List<DeliveryTimeEntity> models = deliveryIntervals.entries
            .expand((entry) => (entry.value as List<dynamic>)
            .map((intervalJson) => DeliveryTimeModel.fromJson(intervalJson, entry.key)))
            .toList();

        return models;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<int> createOrder(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${host}order/store',
        data: params.data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['order_id'];
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<OrderPaginationEntity> fetchOrderHistory(MapParams params) async {
    try {
      final response = await api.dio
          .get('${host}order/index', queryParameters: params.data);

      if (response.statusCode == 200) {
        return OrderPaginationEntity(
            currentPage: response.data['data']['current_page'] ?? 1,
            totalItems: response.data['data']['total_pages'] ?? 1,
            orders: (response.data['data']['orders'] as List)
                .map((e) => OrderHistoryModel.fromJson(e))
                .toList());
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
    // try {
    //   final response = await api.dio.get(
    //     '${host}order/index',
    //   );
    //
    //   if (response.statusCode == 200) {
    //     return (response.data['data'] as List)
    //         .map((e) => OrderHistoryModel.fromJson(e))
    //         .toList();
    //   } else {
    //     throw ServerException();
    //   }
    // } on DioException catch (e) {
    //   return api.handleDioException(e);
    // }
  }

  @override
  Future<bool> cancelOrder(PathParams params) async {
    try {
      final response = await api.dio.get(
        '${host}order/cancel/${params.path}',
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
  Future<List<OrderHistoryEntity>> fetchActiveOrders() async {
    try {
      final response = await api.dio.get(
        '${host}order/active-orders',
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

  @override
  Future<OrderHistoryEntity> fetchOrderById(PathParams params) async {
    try {
      final response = await api.dio.get(
        '${host}order/show/${params.path}',
      );

      if (response.statusCode == 200) {
        return OrderHistoryModel.fromJson(response.data['data']);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<String> getPaymentLink(PaymentParams params) async {
    try {
      final response = await api.dio.get(
        '${host}order/payment-link/${params.invoiceId}',
      );

      if (response.statusCode == 200) {
        return response.data['data']['invoice_url'];
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<num> getMinPrice() async {
    try {
      final response = await api.dio.get(
        '${host}app/get-min-cart-price',
      );

      if (response.statusCode == 200) {
        return int.parse(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }
}
