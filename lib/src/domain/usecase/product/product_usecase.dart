import 'package:abricoz_app/src/domain/entity/product/product_entity.dart';
import 'package:abricoz_app/src/domain/usecase/product/category_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entity/product/search_hint_entity.dart';
import '../../repository/abstract_product_service_profile.dart';
import '../user/sign_in_usecase.dart';


class ProductUseCase {
  ProductUseCase(this.repository);

  final AbstractProductServiceRepository repository;

  Future<Either<Failure, List<ProductEntity>>> fetchProducts(MapParams? params) async {
    return await repository.fetchProducts(params);
  }

  Future<Either<Failure, List<SearchHintEntity>>> fetchSearchHint(MapParams? params) async {
    return await repository.fetchSearchHint(params);
  }
}



