import '../../../domain/entity/product/search_hint_entity.dart';

class  SearchHintModel extends SearchHintEntity {
  const SearchHintModel({
    required super.id,
    required super.name,
  });

  factory SearchHintModel.fromJson(Map<String, dynamic> json) {
    return SearchHintModel(
      id: json['id'],
      name: {
        'ru': json['name_ru'],
        'kz': json['name_kz'],
      //  'en': json['name_en'],
      },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ru': name['ru'],
      'name_kz': name['kz'],
      //'name_en': name['en'],
    };
  }
}