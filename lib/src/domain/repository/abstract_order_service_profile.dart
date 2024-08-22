

import 'package:abricoz_app/src/domain/entity/order/delivery_time_entity.dart';
import 'package:abricoz_app/src/domain/entity/order/order_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entity/order/check_card_entity.dart';

abstract class AbstractOrderServiceRepository {


  Future<Either<Failure, CheckCardEntity>> checkBasketItems(params);

  Future<Either<Failure, List<DeliveryTimeEntity>>> getDeliveryTime();

  Future<Either<Failure, OrderEntity>> createOrder(params);

}