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
      imageUrl: {
        'ru': convertFilePathToUrl(json['image_url_ru']),
        'kz': convertFilePathToUrl(json['image_url_kz']),
        'en': convertFilePathToUrl(json['image_url_en']),
      },
      title: {
        'ru': convertFilePathToUrl(json['title_ru']),
        'kz': convertFilePathToUrl(json['title_kz']),
        'en': convertFilePathToUrl(json['title_en']),
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
      'image_url_ru': imageUrl['ru'],
      'image_url_kz': imageUrl['kz'],
      'image_url_en': imageUrl['en'],
      'title_ru': imageUrl['ru'],
      'title_en': imageUrl['en'],
      'title_kz': imageUrl['kz'],
      'number': number,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
