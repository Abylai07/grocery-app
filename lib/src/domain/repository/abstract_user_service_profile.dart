import 'package:abricoz_app/src/domain/entity/user/banner_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/city_model.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';

abstract class AbstractUserServiceRepository {

  Future<Either<Failure, Map<String, dynamic>>> signInPhone(params);

  Future<Either<Failure, Map<String, dynamic>>> signInCode(params);

  Future<Either<Failure, List<CityEntity>>> getCityList();

  Future<Either<Failure, List<BannerEntity>>> fetchBanners();
}