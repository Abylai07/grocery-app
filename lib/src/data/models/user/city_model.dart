import '../../../domain/entity/user/city_model.dart';

class CityModel extends CityEntity {
  const CityModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  // Factory constructor to create a CityModel from JSON
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert CityModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
