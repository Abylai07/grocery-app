import 'package:hive/hive.dart';

part 'product_adapter.g.dart';

@HiveType(typeId: 1)
class ProductHiveModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int subcategoryId;
  @HiveField(2)
  final int? countryId;
  @HiveField(3)
  final int? brandId;
  @HiveField(4)
  final String? photoUrl;
  @HiveField(5)
  final Map<String, String> name;
  @HiveField(6)
  final Map<String, String> description;
  @HiveField(7)
  final num price;
  @HiveField(8)
  final num? discount;
  @HiveField(9)
  final num? priceWithDiscount;
  @HiveField(10)
  final num? rating;
  @HiveField(11)
  final int? totalSales;
  @HiveField(12)
  final bool? isActive;
  @HiveField(13)
  final DateTime createdAt;
  @HiveField(14)
  final DateTime updatedAt;
  @HiveField(15)
  final int basketCount;

  ProductHiveModel({
    required this.id,
    required this.subcategoryId,
    this.countryId,
    this.brandId,
    this.photoUrl,
    required this.name,
    required this.description,
    required this.price,
    this.discount,
    this.priceWithDiscount,
    this.rating,
    this.totalSales,
    this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.basketCount = 1,
  });

  factory ProductHiveModel.fromJson(Map<String, dynamic> json) {
    return ProductHiveModel(
      id: json['id'],
      subcategoryId: json['subcategory_id'],
      countryId: json['country_id'],
      brandId: json['brand_id'],
      photoUrl: json['photo_url'],
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
      basketCount: json['basket_count'] ?? 0,
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
      'is_active': isActive ?? false ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'basket_count': basketCount,
    };
  }

  ProductHiveModel copyWith({
    int? id,
    int? subcategoryId,
    int? countryId,
    int? brandId,
    String? photoUrl,
    Map<String, String>? name,
    Map<String, String>? description,
    double? price,
    double? discount,
    double? priceWithDiscount,
    double? rating,
    int? totalSales,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? basketCount,
  }) {
    return ProductHiveModel(
      id: id ?? this.id,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      countryId: countryId ?? this.countryId,
      brandId: brandId ?? this.brandId,
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      priceWithDiscount: priceWithDiscount ?? this.priceWithDiscount,
      rating: rating ?? this.rating,
      totalSales: totalSales ?? this.totalSales,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      basketCount: basketCount ?? this.basketCount,
    );
  }
}


