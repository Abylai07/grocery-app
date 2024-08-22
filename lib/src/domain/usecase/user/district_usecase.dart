

import 'package:abricoz_app/src/domain/entity/user/city_model.dart';
import 'package:abricoz_app/src/domain/entity/user/district_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repository/abstract_user_service_profile.dart';

class DistrictUseCase {
  DistrictUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  Future<Either<Failure, List<DistrictEntity>>> getDistricts() async {
    return await repository.getDistricts();
  }
}



