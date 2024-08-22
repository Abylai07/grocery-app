import 'package:abricoz_app/src/data/datasources/product_remote_data_source.dart';
import 'package:abricoz_app/src/domain/entity/product/category_entity.dart';
import 'package:abricoz_app/src/domain/entity/product/product_entity.dart';
import 'package:abricoz_app/src/domain/entity/product/search_hint_entity.dart';
import 'package:abricoz_app/src/domain/entity/product/sub_category_entity.dart';
import 'package:abricoz_app/src/domain/repository/abstract_product_service_profile.dart';
import 'package:dartz/dartz.dart';

import '../../core/check_error_type.dart';
import '../../core/error/failure.dart';

class ProductServiceRepositoryImpl extends AbstractProductServiceRepository {
  ProductServiceRepositoryImpl(this.dataSource, this._networkOperationHelper);
  final ProductRemoteDataSource dataSource;
  final NetworkOperationHelper _networkOperationHelper;

  @override
  Future<Either<Failure, List<CategoryEntity>>> fetchCategory(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchCategory(params));
  }

  @override
  Future<Either<Failure, List<SubCategoryEntity>>> fetchSubCategory(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchSubCategory(params));
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> fetchProducts(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchProducts(params));
  }

  @override
  Future<Either<Failure, List<SearchHintEntity>>> fetchSearchHint(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchSearchHint(params));
  }

  @override
  Future<Either<Failure, ProductEntity>> fetchProductInfo(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchProductInfo(params));
  }
}
