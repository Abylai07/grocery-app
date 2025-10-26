import '../../../domain/entity/order/order_entity.dart';
import '../../../presentation/widgets/main_functions.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.orderId,
    required super.paymentType,
    required super.totalPrice,
    required super.orderStatus,
    required List<OrderProductModel> super.orderProducts,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'],
      paymentType: json['payment_type'],
      totalPrice: json['total_price'],
      orderStatus: json['order_status'],
      orderProducts: (json['order_products'] as List)
          .map((product) => OrderProductModel.fromJson(product))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'payment_type': paymentType,
      'total_price': totalPrice,
      'order_status': orderStatus,
      'order_products': orderProducts
          .map((product) => (product as OrderProductModel).toJson())
          .toList(),
    };
  }
}

class OrderProductModel extends OrderProductEntity {
  const OrderProductModel({
    required super.productId,
    required super.name,
    required super.price,
    super.priceWithDiscount,
    super.photoUrl,
    super.weight,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      productId: json['product_id'],
      photoUrl: convertFilePathToUrl(json['photo_url']),
      name: {
        'ru': json['name_ru'],
        'kz': json['name_kz'],
       // 'en': json['name_en'],
      },
      price: json['price'],
      priceWithDiscount: json['price_with_discount'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'photo_url': photoUrl,
      'name_ru': name['ru'],
      'name_kz': name['kz'],
     // 'name_en': name['en'],
      'price': price,
      'price_with_discount': priceWithDiscount,
      'weight': weight,
    };
  }
}
