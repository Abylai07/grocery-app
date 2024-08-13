import 'package:abricoz_app/src/domain/entity/user/banner_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/city_model.dart';
import 'package:abricoz_app/src/domain/repository/abstract_user_service_profile.dart';
import 'package:dartz/dartz.dart';

import '../../core/check_error_type.dart';
import '../../core/error/failure.dart';
import '../datasources/user_remote_data_source.dart';

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
  Future<Either<Failure, List<CityEntity>>> getCityList() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.getCityList());
  }

  @override
  Future<Either<Failure, List<BannerEntity>>> fetchBanners() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchBanners());
  }
}
