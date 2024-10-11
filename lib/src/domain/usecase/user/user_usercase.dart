import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repository/abstract_user_service_profile.dart';

class UserUseCase {
  UserUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  Future<Either<Failure, bool>> deleteUser() async {
    return await repository.deleteUser();
  }
}