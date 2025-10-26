import 'package:grocery_app/src/domain/entity/user/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repository/abstract_user_service_profile.dart';

class UserUseCase {
  UserUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  Future<Either<Failure, bool>> deleteUser() async {
    return await repository.deleteUser();
  }

  Future<Either<Failure, UserEntity>> fetchUser() async {
    return await repository.fetchUser();
  }
}