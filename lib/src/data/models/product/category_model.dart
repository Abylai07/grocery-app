import '../../../domain/entity/product/category_entity.dart';
import '../../../presentation/widgets/main_functions.dart';

class CategoryModel extends CategoryEntity{
  const CategoryModel({
    required super.id,
    super.photoUrl,
    super.mobileUrl,
    super.forwardSubcategoryId,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      photoUrl: json['photo_url'],
      forwardSubcategoryId: json['forward_subcategory_id'],
      mobileUrl: json['mobile_image_url'] != null ? convertFilePathToUrl(json['mobile_image_url']) : json['mobile_image_url'],
      name: {
        'ru': json['name_ru'],
        'kz': json['name_kz'],
       // 'en': json['name_en'],
      },
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo_url': photoUrl,
      'mobile_url': mobileUrl,
      'forward_subcategory_id': forwardSubcategoryId,
      'name_ru': name['ru'],
      'name_kz': name['kz'],
     // 'name_en': name['en'],
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
