import 'package:equatable/equatable.dart';

class PivotEntity extends Equatable {
  final int orderId;
  final int productId;
  final int productQuantity;
  final double productPrice;
  final double productDiscount;

  const PivotEntity({
    required this.orderId,
    required this.productId,
    required this.productQuantity,
    required this.productPrice,
    required this.productDiscount,
  });

  @override
  List<Object?> get props => [orderId, productId, productQuantity, productPrice, productDiscount];
}
