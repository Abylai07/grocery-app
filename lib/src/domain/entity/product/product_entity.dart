import 'package:grocery_app/src/domain/entity/order/pivot_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/product/pivot_model.dart';

class ProductEntity extends Equatable {
  final int id;
  final int? subcategoryId;
  final int? countryId;
  final int? brandId;
  final int? productQuantity;
  final String? photoUrl;
  final Map<String, String> name;
  final Map<String, String> description;
  final num price;
  final num? discount;
  final num? priceWithDiscount;
  final num? rating;
  final int? totalSales;
  final int? amount;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? weight;
  final num? calories;
  final num? proteins;
  final num? fats;
  final num? carbohydrates;
  final PivotEntity? pivot;

  const ProductEntity({
    required this.id,
    this.subcategoryId,
    this.countryId,
    this.brandId,
    this.productQuantity,
    this.photoUrl,
    this.amount,
    required this.name,
    required this.description,
    required this.price,
    this.pivot,
    this.discount,
    this.priceWithDiscount,
    this.rating,
    this.totalSales,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    this.weight,
    this.calories,
    this.proteins,
    this.fats,
    this.carbohydrates,
  });

  @override
  List<Object?> get props => [
        id,
        subcategoryId,
        countryId,
        brandId,
        photoUrl,
        name,
        pivot,
    amount,
        description,
        price,
        discount,
        productQuantity,
        priceWithDiscount,
        rating,
        totalSales,
        isActive,
        createdAt,
        updatedAt,
        weight,
        calories,
        proteins,
        fats,
        carbohydrates,
      ];
}

class SubcategoryEntity extends Equatable {
  final int id;
  final int categoryId;
  final String? photoUrl;
  final Map<String, String> name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SubcategoryEntity({
    required this.id,
    required this.categoryId,
    this.photoUrl,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        categoryId,
        photoUrl,
        name,
        createdAt,
        updatedAt,
      ];
}

class BrandEntity extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BrandEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [
        id,
        name,
        createdAt,
        updatedAt,
      ];
}

class CountryEntity extends Equatable {
  final int id;
  final String name;

  const CountryEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
