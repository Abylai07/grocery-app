import 'package:grocery_app/src/domain/entity/user/address_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repository/abstract_user_service_profile.dart';
import '../product/category_usecase.dart';
import '../product/product_usecase.dart';

class AddressUseCase {
  AddressUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  Future<Either<Failure, List<AddressEntity>>> fetchAddress() async {
    return await repository.fetchAddress();
  }

  Future<Either<Failure, AddressEntity>> createAddress(PathMapParams params) async {
    return await repository.createAddress(params);
  }

  Future<Either<Failure, Map<String, dynamic>>> deleteAddress(PathParams params) async {
    return await repository.deleteAddress(params);
  }
}



