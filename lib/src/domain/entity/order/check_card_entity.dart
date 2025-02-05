import 'package:equatable/equatable.dart';

class CheckCardEntity extends Equatable {
  const CheckCardEntity({
    required this.products,
    required this.totalPrice,
    required this.inactivatedProducts,
    required this.shortagedProducts,
  });

  final List<ProductCardEntity> products;
  final num totalPrice;
  final List<ProductCardEntity> inactivatedProducts;
  final List<ShortagedProductEntity> shortagedProducts;

  @override
  List<Object?> get props => [
    products,
    totalPrice,
    inactivatedProducts,
    shortagedProducts,
  ];
}

class ProductCardEntity extends Equatable {
  final int id;
  final int? productQuantity;
  final int? availableQuantity;
  final String? photoUrl;
  final Map<String, String> name;
  final num price;
  final num? discount;
  final num? priceWithDiscount;
  final bool isActive;
  final String? weight;

  const ProductCardEntity({
    required this.id,
    this.productQuantity,
    this.availableQuantity,
    this.photoUrl,
    required this.name,
    required this.price,
    this.discount,
    this.priceWithDiscount,
    required this.isActive,
    this.weight,
  });

  @override
  List<Object?> get props => [
    id,
    photoUrl,
    name,
    price,
    discount,
    productQuantity,
    priceWithDiscount,
    availableQuantity,
    isActive,
    weight,
  ];
}

class ShortagedProductEntity extends Equatable {
  final int id;
  final int requestedQuantity;
  final int availableQuantity;
  final String? photoUrl;
  final Map<String, String> name;
  final num price;
  final num? priceWithDiscount;
  final num? discount;
  final String? weight;

  const ShortagedProductEntity({
    required this.id,
    required this.requestedQuantity,
    required this.availableQuantity,
    this.photoUrl,
    required this.name,
    required this.price,
    this.priceWithDiscount,
    this.discount,
    this.weight,
  });

  @override
  List<Object?> get props => [
    id,
    requestedQuantity,
    availableQuantity,
    photoUrl,
    name,
    price,
    priceWithDiscount,
    discount,
    weight,
  ];

  Map<String, dynamic> toJson() {
    return {};
  }
}
