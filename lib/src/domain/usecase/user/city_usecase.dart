

import 'package:grocery_app/src/domain/entity/user/city_model.dart';
import 'package:grocery_app/src/domain/entity/user/location_entity.dart';
import 'package:grocery_app/src/domain/usecase/product/product_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repository/abstract_user_service_profile.dart';

class CityUseCase {
  CityUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  Future<Either<Failure, List<CityEntity>>> getCity() async {
    return await repository.getCityList();
  }

  Future<Either<Failure, PointsEntity>> getCityPolygon(PathParams params) async {
    return await repository.getCityPolygon(params);
  }
}



