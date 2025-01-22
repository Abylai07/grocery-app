import 'package:abricoz_app/src/domain/entity/order/order_history_entity.dart';
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

class OrderPaginationEntity extends Equatable {
  const OrderPaginationEntity({required this.orders, required this.totalItems, required this.currentPage});
  final List<OrderHistoryEntity> orders;
  final int currentPage;
  final int totalItems;

  @override
  List<Object?> get props => [orders, currentPage, totalItems];
}
