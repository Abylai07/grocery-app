import 'package:abricoz_app/src/domain/entity/product/category_entity.dart';
import 'package:abricoz_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';
import '../../entity/product/sub_category_entity.dart';
import '../../repository/abstract_product_service_profile.dart';


class CategoryUseCase {
  CategoryUseCase(this.repository);

  final AbstractProductServiceRepository repository;

  Future<Either<Failure, List<CategoryEntity>>> fetchCategory(MapParams? params) async {
    return await repository.fetchCategory(params);
  }

  Future<Either<Failure, List<SubCategoryEntity>>> fetchSubCategory(MapParams? params) async {
    return await repository.fetchSubCategory(params);
  }
}


class PathMapParams extends Equatable{
  const PathMapParams({required this.data, required this.path});

  final Map<String, dynamic> data;
  final String path;
  @override
  List<Object> get props => [data, path];
}


