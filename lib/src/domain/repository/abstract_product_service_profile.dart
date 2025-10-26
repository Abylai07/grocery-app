import 'package:grocery_app/src/domain/entity/product/category_entity.dart';
import 'package:grocery_app/src/domain/entity/product/product_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entity/product/pagination_entity.dart';
import '../entity/product/search_hint_entity.dart';
import '../entity/product/sub_category_entity.dart';

abstract class AbstractProductServiceRepository {

  Future<Either<Failure, List<CategoryEntity>>> fetchCategory(params);

  Future<Either<Failure, List<SubCategoryEntity>>> fetchSubCategory(params);

  Future<Either<Failure, PaginationEntity>> fetchProducts(params);

  Future<Either<Failure, List<SearchHintEntity>>> fetchSearchHint(params);

  Future<Either<Failure, ProductEntity>> fetchProductInfo(params);
}