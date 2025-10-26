import 'package:grocery_app/src/domain/entity/user/card_entity.dart';
import 'package:grocery_app/src/domain/usecase/product/product_usecase.dart';
import 'package:grocery_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entity/product/product_entity.dart';
import '../../repository/abstract_user_service_profile.dart';

class CardsUseCase {
  CardsUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  Future<Either<Failure, List<CardEntity>>> fetchMyCards() async {
    return await repository.fetchMyCards();
  }

  Future<Either<Failure, bool>> deleteCard(PathParams params) async {
    return await repository.deleteCard(params);
  }
}



