import 'package:grocery_app/src/domain/entity/order/order_history_entity.dart';
import 'package:grocery_app/src/domain/entity/product/pagination_entity.dart';
import 'package:grocery_app/src/domain/repository/abstract_order_service_profile.dart';
import 'package:grocery_app/src/domain/usecase/product/product_usecase.dart';
import 'package:grocery_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';


class OrderHistoryUseCase {
  OrderHistoryUseCase(this.repository);

  final AbstractOrderServiceRepository repository;

  Future<Either<Failure, OrderPaginationEntity>> fetchOrderHistory(MapParams params) async {
    return await repository.fetchOrderHistory(params);
  }

  Future<Either<Failure, List<OrderHistoryEntity>>> fetchActiveOrders() async {
    return await repository.fetchActiveOrders();
  }

  Future<Either<Failure, OrderHistoryEntity>> fetchOrderById(PathParams params) async {
    return await repository.fetchOrderById(params);
  }
}




