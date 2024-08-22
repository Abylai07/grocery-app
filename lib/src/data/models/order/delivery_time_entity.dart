import '../../../domain/entity/order/delivery_time_entity.dart';

class DeliveryTimeModel extends DeliveryTimeEntity {
  const DeliveryTimeModel({
    required super.id,
    required super.name,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory DeliveryTimeModel.fromJson(Map<String, dynamic> json) {
    return DeliveryTimeModel(
      id: json['id'],
      name: json['name'],
      isActive: json['is_active'] == 1,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
