import '../../../domain/entity/order/pivot_entity.dart';

class PivotModel extends PivotEntity {
  const PivotModel({
    required super.orderId,
    required super.productId,
    required super.productQuantity,
    required super.productPrice,
    required super.productDiscount,
  });

  /// Factory method to create a `PivotModel` from JSON
  factory PivotModel.fromJson(Map<String, dynamic> json) {
    return PivotModel(
      orderId: json['order_id'],
      productId: json['product_id'],
      productQuantity: json['product_quantity'],
      productPrice: (json['product_price'] as num).toDouble(),
      productDiscount: (json['product_discount'] as num).toDouble(),
    );
  }

  /// Convert `PivotModel` back to JSON
  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'product_id': productId,
      'product_quantity': productQuantity,
      'product_price': productPrice,
      'product_discount': productDiscount,
    };
  }
}
