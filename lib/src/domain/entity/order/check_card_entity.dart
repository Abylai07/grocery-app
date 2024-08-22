import 'package:equatable/equatable.dart';

class CheckCardEntity extends Equatable {
  const CheckCardEntity({required this.products, required this.totalPrice});
  final List<ProductCardEntity> products;
  final num totalPrice;

  @override
  List<Object?> get props => [products, totalPrice];
}

class ProductCardEntity extends Equatable {
  final int id;
  final int? productQuantity;
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
        isActive,
        weight,
      ];
}
