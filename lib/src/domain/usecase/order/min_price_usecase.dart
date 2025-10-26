import 'package:grocery_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_order_service_profile.dart';

class MinPriceUsecase extends UseCase<num?, MapParams> {
  MinPriceUsecase(this.repository);

  final AbstractOrderServiceRepository repository;

  @override
  Future<Either<Failure, num>> call(MapParams? params) async {
    return await repository.getMinPrice();
  }
}
