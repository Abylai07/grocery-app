import 'package:abricoz_app/src/core/error/failure.dart';
import 'package:abricoz_app/src/domain/entity/order/delivery_time_entity.dart';
import 'package:abricoz_app/src/domain/entity/order/order_entity.dart';
import 'package:abricoz_app/src/domain/entity/product/pagination_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/check_error_type.dart';
import '../../domain/entity/order/check_card_entity.dart';
import '../../domain/entity/order/order_history_entity.dart';
import '../../domain/repository/abstract_order_service_profile.dart';
import '../datasources/order_remote_data_source.dart';

class OrderServiceRepositoryImpl extends AbstractOrderServiceRepository {
  OrderServiceRepositoryImpl(this.dataSource, this._networkOperationHelper);
  final OrderRemoteDataSource dataSource;
  final NetworkOperationHelper _networkOperationHelper;

  @override
  Future<Either<Failure, CheckCardEntity>> checkBasketItems(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.checkBasketItems(params));
  }

  @override
  Future<Either<Failure, List<DeliveryTimeEntity>>> getDeliveryTime() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.getDeliveryTime());
  }

  @override
  Future<Either<Failure, int>> createOrder(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.createOrder(params));
  }

  @override
  Future<Either<Failure, OrderPaginationEntity>> fetchOrderHistory(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchOrderHistory(params));
  }

  @override
  Future<Either<Failure, bool>> cancelOrder(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.cancelOrder(params));
  }

  @override
  Future<Either<Failure, List<OrderHistoryEntity>>> fetchActiveOrders() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchActiveOrders());
  }

  @override
  Future<Either<Failure, OrderHistoryEntity>> fetchOrderById(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchOrderById(params));
  }

  @override
  Future<Either<Failure, String>> getPaymentLink(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.getPaymentLink(params));
  }

  @override
  Future<Either<Failure, num>> getMinPrice() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.getMinPrice());
  }
}
