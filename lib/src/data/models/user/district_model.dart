import 'package:abricoz_app/src/domain/entity/user/district_entity.dart';

class DistrictModel extends DistrictEntity {
  const DistrictModel({
    required super.id,
    required super.name,
    required super.deliveryPrice,
    required super.createdAt,
    required super.updatedAt,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'],
      name: json['name'],
      deliveryPrice: json['delivery_price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'delivery_price': deliveryPrice,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
