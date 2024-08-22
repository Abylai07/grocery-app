import 'package:abricoz_app/src/domain/entity/user/address_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/city_model.dart';
import 'package:abricoz_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repository/abstract_user_service_profile.dart';
import '../product/category_usecase.dart';

class AddressUseCase {
  AddressUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  Future<Either<Failure, List<AddressEntity>>> fetchAddress() async {
    return await repository.fetchAddress();
  }

  Future<Either<Failure, AddressEntity>> createAddress(PathMapParams params) async {
    return await repository.createAddress(params);
  }
}



