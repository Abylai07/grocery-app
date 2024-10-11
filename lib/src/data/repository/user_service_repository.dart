import 'package:abricoz_app/src/domain/entity/user/address_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/banner_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/city_model.dart';
import 'package:abricoz_app/src/domain/entity/user/district_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/user_entity.dart';
import 'package:abricoz_app/src/domain/repository/abstract_user_service_profile.dart';
import 'package:dartz/dartz.dart';

import '../../core/check_error_type.dart';
import '../../core/error/failure.dart';
import '../../domain/entity/product/product_entity.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user/user_model.dart';

class UserServiceRepositoryImpl extends AbstractUserServiceRepository {
  UserServiceRepositoryImpl(this.dataSource, this._networkOperationHelper);
  final UserRemoteDataSource dataSource;
  final NetworkOperationHelper _networkOperationHelper;

  @override
  Future<Either<Failure, Map<String, dynamic>>> signInPhone(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.signInPhone(params));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> signInCode(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.signInCode(params));
  }

  @override
  Future<Either<Failure, UserEntity>> setName(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.setName(params));
  }

  @override
  Future<Either<Failure, List<CityEntity>>> getCityList() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.getCityList());
  }

  @override
  Future<Either<Failure, List<BannerEntity>>> fetchBanners() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchBanners());
  }

  @override
  Future<Either<Failure, AddressEntity>> createAddress(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.createAddress(params));
  }

  @override
  Future<Either<Failure, List<AddressEntity>>> fetchAddress() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchAddress());
  }

  @override
  Future<Either<Failure, List<DistrictEntity>>> getDistricts() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.getDistricts());
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> fetchFavorite() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchFavorites());
  }

  @override
  Future<Either<Failure, ProductEntity>> storeFavorite(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.storeFavorite(params));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteFavorite(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.deleteFavorite(params));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteAddress(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.deleteAddress(params));
  }

  @override
  Future<Either<Failure, bool>> deleteUser() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.deleteUser());
  }
}
