import 'package:grocery_app/src/domain/entity/order/delivery_time_entity.dart';
import 'package:grocery_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_order_service_profile.dart';

class DeliveryTimeUseCase extends UseCase<List<DeliveryTimeEntity>?, MapParams> {
  DeliveryTimeUseCase(this.repository);

  final AbstractOrderServiceRepository repository;

  @override
  Future<Either<Failure, List<DeliveryTimeEntity>>> call(MapParams? params) async {
    return await repository.getDeliveryTime();
  }
}
