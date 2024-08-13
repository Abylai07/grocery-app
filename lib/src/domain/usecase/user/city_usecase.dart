

import 'package:abricoz_app/src/domain/entity/user/city_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repository/abstract_user_service_profile.dart';

class CityUseCase {
  CityUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  Future<Either<Failure, List<CityEntity>>> getCity() async {
    return await repository.getCityList();
  }
}



