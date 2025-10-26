import '../../../domain/entity/user/banner_entity.dart';
import '../../../presentation/widgets/main_functions.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    required super.id,
    required super.imageUrl,
    required super.number,
    required super.createdAt,
    required super.updatedAt,
    required super.title,
  });

  // Factory method to create a BannerModel from JSON
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      imageUrl: convertFilePathToUrl(json['image_url']),
      title: {
        'ru': json['title_ru'],
        'kz': json['title_kz'],
      //  'en': json['title_en'],
      },
      number: json['number'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert a BannerModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'title_ru': title['ru'],
     // 'title_en': title['en'],
      'title_kz': title['kz'],
      'number': number,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
