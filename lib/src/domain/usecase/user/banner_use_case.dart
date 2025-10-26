import 'package:grocery_app/src/domain/entity/user/banner_entity.dart';
import 'package:grocery_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_user_service_profile.dart';

class BannerUseCase extends UseCase<List<BannerEntity>?, MapParams> {
  BannerUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  @override
  Future<Either<Failure, List<BannerEntity>>> call(MapParams? params) async {
    return await repository.fetchBanners();
  }
}