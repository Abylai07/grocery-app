import 'package:abricoz_app/src/domain/usecase/product/product_usecase.dart';
import 'package:abricoz_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entity/product/product_entity.dart';
import '../../repository/abstract_user_service_profile.dart';

class FavoriteUseCase {
  FavoriteUseCase(this.repository);

  final AbstractUserServiceRepository repository;

  Future<Either<Failure, List<ProductEntity>>> fetchFavorite() async {
    return await repository.fetchFavorite();
  }

  Future<Either<Failure, ProductEntity>> storeFavorite(MapParams params) async {
    return await repository.storeFavorite(params);
  }

  Future<Either<Failure, Map<String, dynamic>>> deleteFavorite(PathParams params) async {
    return await repository.deleteFavorite(params);
  }
}



