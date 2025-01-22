import '../../../domain/entity/order/order_history_entity.dart';
import '../product/product_model.dart';


class OrderHistoryModel extends OrderHistoryEntity {
  const OrderHistoryModel({
    required super.id,
    required super.userId,
    required super.orderStatusId,
    required super.deliveryIntervalId,
    required super.paymentTypeId,
    required super.cityId,
    required super.addressStreetAndHouse,
    required super.addressApartment,
     super.addressEntrance,
     super.addressFloor,
     super.addressComment,
    required super.deliveryDate,
    required super.productsPrice,
    required super.deliveryPrice,
    required super.totalPrice,
    required super.createdAt,
    required super.updatedAt,
    required super.orderStatus,
    required super.deliveryInterval,
    required List<ProductModel> super.products,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'],
      userId: json['user_id'],
      orderStatusId: json['order_status_id'],
      deliveryIntervalId: json['delivery_interval_id'],
      paymentTypeId: json['payment_type_id'],
      cityId: json['city_id'],
      addressStreetAndHouse: json['address_street_and_house'],
      addressApartment: json['address_apartment'],
      addressEntrance: json['address_entrance'],
      addressFloor: json['address_floor'],
      addressComment: json['address_comment'],
      deliveryDate: DateTime.parse(json['delivery_date']),
      productsPrice: (json['products_price'] as num).toDouble(),
      deliveryPrice: (json['delivery_price'] as num).toDouble(),
      totalPrice: (json['total_price'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      orderStatus: OrderStatusModel.fromJson(json['order_status']),
      deliveryInterval: DeliveryIntervalModel.fromJson(json['delivery_interval']),
      products: (json['products'] as List)
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'order_status_id': orderStatusId,
      'delivery_interval_id': deliveryIntervalId,
      'payment_type_id': paymentTypeId,
      'city_id': cityId,
      'address_street_and_house': addressStreetAndHouse,
      'address_apartment': addressApartment,
      'address_entrance': addressEntrance,
      'address_floor': addressFloor,
      'address_comment': addressComment,
      'delivery_date': deliveryDate.toIso8601String(),
      'products_price': productsPrice,
      'delivery_price': deliveryPrice,
      'total_price': totalPrice,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'order_status': (orderStatus as OrderStatusModel).toJson(),
      'delivery_interval': (deliveryInterval as DeliveryIntervalModel).toJson(),
      'products': products.map((product) => (product as ProductModel).toJson()).toList(),
    };
  }
}


class OrderStatusModel extends OrderStatusEntity {
  const OrderStatusModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class DeliveryIntervalModel extends DeliveryIntervalEntity {
  const DeliveryIntervalModel({
    required super.id,
    required super.name,
     super.createdAt,
     super.updatedAt,
  });

  factory DeliveryIntervalModel.fromJson(Map<String, dynamic> json) {
    return DeliveryIntervalModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ?  DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

