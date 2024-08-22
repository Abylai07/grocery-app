import 'package:abricoz_app/src/domain/entity/order/order_entity.dart';
import 'package:abricoz_app/src/domain/repository/abstract_order_service_profile.dart';
import 'package:abricoz_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';


class OrderUseCase {
  OrderUseCase(this.repository);

  final AbstractOrderServiceRepository repository;

  Future<Either<Failure, OrderEntity>> createOrder(MapParams? params) async {
    return await repository.createOrder(params);
  }

}




