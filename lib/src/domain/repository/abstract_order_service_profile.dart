

import 'package:abricoz_app/src/domain/entity/order/delivery_time_entity.dart';
import 'package:abricoz_app/src/domain/entity/order/order_entity.dart';
import 'package:abricoz_app/src/domain/entity/product/pagination_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entity/order/check_card_entity.dart';
import '../entity/order/order_history_entity.dart';

abstract class AbstractOrderServiceRepository {


  Future<Either<Failure, CheckCardEntity>> checkBasketItems(params);

  Future<Either<Failure, List<DeliveryTimeEntity>>> getDeliveryTime();

  Future<Either<Failure, int>> createOrder(params);

  Future<Either<Failure, OrderPaginationEntity>> fetchOrderHistory(params);

  Future<Either<Failure, List<OrderHistoryEntity>>> fetchActiveOrders();

  Future<Either<Failure, OrderHistoryEntity>> fetchOrderById(params);

  Future<Either<Failure, bool>> cancelOrder(params);

  Future<Either<Failure, String>> getPaymentLink(params);
}