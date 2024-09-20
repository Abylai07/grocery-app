import 'package:equatable/equatable.dart';

import '../product/product_entity.dart';

class OrderHistoryEntity extends Equatable {
  final int id;
  final int userId;
  final int orderStatusId;
  final int deliveryIntervalId;
  final int paymentTypeId;
  final int cityId;
  final int districtId;
    final String addressStreetAndHouse;
  final String addressApartment;
  final String? addressEntrance;
  final String? addressFloor;
  final String? addressComment;
  final DateTime deliveryDate;
  final double productsPrice;
  final double deliveryPrice;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OrderStatusEntity orderStatus;
  final DeliveryIntervalEntity deliveryInterval;
  final List<ProductEntity> products;

  const OrderHistoryEntity({
    required this.id,
    required this.userId,
    required this.orderStatusId,
    required this.deliveryIntervalId,
    required this.paymentTypeId,
    required this.cityId,
    required this.districtId,
    required this.addressStreetAndHouse,
    required this.addressApartment,
     this.addressEntrance,
     this.addressFloor,
     this.addressComment,
    required this.deliveryDate,
    required this.productsPrice,
    required this.deliveryPrice,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.orderStatus,
    required this.deliveryInterval,
    required this.products,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    orderStatusId,
    deliveryIntervalId,
    paymentTypeId,
    cityId,
    districtId,
    addressStreetAndHouse,
    addressApartment,
    addressEntrance,
    addressFloor,
    addressComment,
    deliveryDate,
    productsPrice,
    deliveryPrice,
    totalPrice,
    createdAt,
    updatedAt,
    orderStatus,
    deliveryInterval,
    products,
  ];
}

class OrderStatusEntity extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderStatusEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt];
}

class DeliveryIntervalEntity extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DeliveryIntervalEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt];
}

