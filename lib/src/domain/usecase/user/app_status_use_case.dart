import 'package:grocery_app/src/domain/entity/user/app_config_entity.dart';
import 'package:grocery_app/src/domain/entity/user/banner_entity.dart';
import 'package:grocery_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_user_service_profile.dart';

class AppStatusUseCase extends UseCase<AppConfigEntity?, MapParams> {
  AppStatusUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  @override
  Future<Either<Failure, AppConfigEntity>> call(MapParams? params) async {
    return await repository.fetchAppSettings();
  }
}