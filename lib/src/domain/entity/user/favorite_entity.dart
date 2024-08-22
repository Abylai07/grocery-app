import 'package:equatable/equatable.dart';

import '../product/product_entity.dart';

class FavoriteEntity extends Equatable {
  final int id;
  final int userId;
  final int productId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProductEntity product;

  const FavoriteEntity({
    required this.id,
    required this.userId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  @override
  List<Object?> get props => [id, userId, productId, createdAt, updatedAt, product];
}
