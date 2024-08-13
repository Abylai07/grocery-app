import '../../../domain/entity/product/product_entity.dart';
import '../../../presentation/widgets/main_functions.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.subcategoryId,
    required super.countryId,
    required super.brandId,
    super.photoUrl,
    required super.name,
    required super.description,
    required super.price,
    super.discount,
    super.priceWithDiscount,
    super.rating,
    required super.totalSales,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
    super.weight,
    super.calories,
    super.proteins,
    super.fats,
    super.carbohydrates,
    super.brand,
    super.country,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      subcategoryId: json['subcategory_id'],
      countryId: json['country_id'],
      brandId: json['brand_id'],
      photoUrl: convertFilePathToUrl(json['photo_url']),
      name: {
        'ru': json['name_ru'],
        'kz': json['name_kz'],
        'en': json['name_en'],
      },
      description: {
        'ru': json['description_ru'],
        'kz': json['description_kz'],
        'en': json['description_en'],
      },
      price: json['price'],
      discount: json['discount'],
      priceWithDiscount: json['price_with_discount'],
      rating: json['rating'],
      totalSales: json['total_sales'],
      isActive: json['is_active'] == 1,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      weight: json['weight'],
      calories: json['calories']?.toDouble(),
      proteins: json['proteins']?.toDouble(),
      fats: json['fats']?.toDouble(),
      carbohydrates: json['carbohydrates']?.toDouble(),
      brand: json['brand'] != null ? BrandModel.fromJson(json['brand']) : json['brand'],
      country: json['country'] != null ? CountryModel.fromJson(json['country']) : json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subcategory_id': subcategoryId,
      'country_id': countryId,
      'brand_id': brandId,
      'photo_url': photoUrl,
      'name_ru': name['ru'],
      'name_kz': name['kz'],
      'name_en': name['en'],
      'description_ru': description['ru'],
      'description_kz': description['kz'],
      'description_en': description['en'],
      'price': price,
      'discount': discount,
      'price_with_discount': priceWithDiscount,
      'rating': rating,
      'total_sales': totalSales,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'weight': weight,
      'calories': calories,
      'proteins': proteins,
      'fats': fats,
      'carbohydrates': carbohydrates,
      'country': country,
      'brand': brand,
    };
  }
}


class SubcategoryModel extends SubcategoryEntity {
  const SubcategoryModel({
    required super.id,
    required super.categoryId,
    super.photoUrl,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['id'],
      categoryId: json['category_id'],
      photoUrl: convertFilePathToUrl(json['photo_url']),
      name: {
        'ru': json['name_ru'],
        'kz': json['name_kz'],
        'en': json['name_en'],
      },
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'photo_url': photoUrl,
      'name_ru': name['ru'],
      'name_kz': name['kz'],
      'name_en': name['en'],
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class BrandModel extends BrandEntity {
  const BrandModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
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

class CountryModel extends CountryEntity {
  const CountryModel({
    required super.id,
    required super.name,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
