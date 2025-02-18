import 'package:abricoz_app/src/domain/entity/user/address_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/banner_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/card_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/city_model.dart';
import 'package:abricoz_app/src/domain/entity/user/location_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entity/product/product_entity.dart';
import '../entity/user/user_entity.dart';

abstract class AbstractUserServiceRepository {

  Future<Either<Failure, Map<String, dynamic>>> signInPhone(params);

  Future<Either<Failure, UserEntity>> signInCode(params);

  Future<Either<Failure, UserEntity>> setName(params);

  Future<Either<Failure, List<CityEntity>>> getCityList();

  Future<Either<Failure, List<LocationEntity>>> getCityPolygon(params);

  Future<Either<Failure, List<BannerEntity>>> fetchBanners();

  Future<Either<Failure, AddressEntity>> createAddress(params);

  Future<Either<Failure, Map<String, dynamic>>> deleteAddress(params);

  Future<Either<Failure, List<AddressEntity>>> fetchAddress();

  Future<Either<Failure, ProductEntity>> storeFavorite(params);

  Future<Either<Failure, Map<String, dynamic>>> deleteFavorite(params);

  Future<Either<Failure, List<ProductEntity>>> fetchFavorite();

  Future<Either<Failure, List<CardEntity>>> fetchMyCards();

  Future<Either<Failure, bool>> deleteCard(params);

  Future<Either<Failure, bool>> deleteUser();
}