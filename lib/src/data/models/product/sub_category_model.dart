import '../../../domain/entity/product/sub_category_entity.dart';
import '../../../presentation/widgets/main_functions.dart';

class SubCategoryModel extends SubCategoryEntity {

  const SubCategoryModel({
    required super.id,
    required super.categoryId,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
    required super.photoUrl,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      categoryId: json['category_id'],
      name: {
        'ru': json['name_ru'],
        'kz': json['name_kz'],
       // 'en': json['name_en'],
      },
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      photoUrl: json['image_url'] != null ? convertFilePathToUrl(json['image_url']) : json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'name_ru': name['ru'],
      'name_kz': name['kz'],
     // 'name_en': name['en'],
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'image_url': photoUrl,
    };
  }
}
