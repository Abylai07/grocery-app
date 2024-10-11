import 'package:abricoz_app/src/domain/entity/user/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';
import '../../repository/abstract_user_service_profile.dart';


class SignInUseCase {
  SignInUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  Future<Either<Failure, Map<String, dynamic>>> signInPhone(MapParams? params) async {
    return await repository.signInPhone(params);
  }

  Future<Either<Failure, Map<String, dynamic>>> signInCode(MapParams? params) async {
    return await repository.signInCode(params);
  }

  Future<Either<Failure, UserEntity>> setName(MapParams? params) async {
    return await repository.setName(params);
  }
}

class MapParams extends Equatable{
  const MapParams(this.data);

  final Map<String, dynamic> data;
  @override
  List<Object> get props => [data];
}
