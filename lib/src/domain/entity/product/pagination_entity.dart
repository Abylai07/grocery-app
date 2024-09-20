import 'package:abricoz_app/src/domain/entity/product/product_entity.dart';
import 'package:equatable/equatable.dart';

class PaginationEntity extends Equatable {
  const PaginationEntity({required this.products, required this.totalItems, required this.currentPage});
  final List<ProductEntity> products;
  final int currentPage;
  final int totalItems;

  @override
  List<Object?> get props => [products, currentPage, totalItems];
}
