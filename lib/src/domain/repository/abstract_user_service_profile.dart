import 'package:abricoz_app/src/domain/entity/user/address_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/banner_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/city_model.dart';
import 'package:abricoz_app/src/domain/entity/user/favorite_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entity/product/product_entity.dart';
import '../entity/user/district_entity.dart';

abstract class AbstractUserServiceRepository {

  Future<Either<Failure, Map<String, dynamic>>> signInPhone(params);

  Future<Either<Failure, Map<String, dynamic>>> signInCode(params);

  Future<Either<Failure, List<CityEntity>>> getCityList();

  Future<Either<Failure, List<DistrictEntity>>> getDistricts();

  Future<Either<Failure, List<BannerEntity>>> fetchBanners();

  Future<Either<Failure, AddressEntity>> createAddress(params);

  Future<Either<Failure, List<AddressEntity>>> fetchAddress();

  Future<Either<Failure, FavoriteEntity>> storeFavorite(params);

  Future<Either<Failure, Map<String, dynamic>>> deleteFavorite(params);

  Future<Either<Failure, List<FavoriteEntity>>> fetchFavorite();
}