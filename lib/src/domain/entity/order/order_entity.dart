import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final int orderId;
  final String paymentType;
  final num totalPrice;
  final String orderStatus;
  final List<OrderProductEntity> orderProducts;

  const OrderEntity({
    required this.orderId,
    required this.paymentType,
    required this.totalPrice,
    required this.orderStatus,
    required this.orderProducts,
  });

  @override
  List<Object?> get props => [orderId, paymentType, totalPrice, orderStatus, orderProducts];
}

class OrderProductEntity extends Equatable {
  final int productId;
  final Map<String, String> name;
  final num price;
  final num? priceWithDiscount;
  final String? weight;
  final String? photoUrl;

  const OrderProductEntity( {
    required this.productId,
    required this.name,
    required this.price,
    this.priceWithDiscount,
    this.photoUrl,
    this.weight,
  });

  @override
  List<Object?> get props => [productId, name, price, priceWithDiscount, photoUrl, weight];
}
