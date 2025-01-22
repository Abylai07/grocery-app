import '../../../domain/entity/order/delivery_time_entity.dart';


class DeliveryTimeModel extends DeliveryTimeEntity {
  const DeliveryTimeModel({
    required super.id,
    required super.name,
    required super.startTime,
    required super.endTime,
    required super.isActive,
    required super.date,
  });

  factory DeliveryTimeModel.fromJson(Map<String, dynamic> json, String date) {
    return DeliveryTimeModel(
      id: json['id'],
      name: json['name'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      date: DateTime.parse(date),
      isActive: json['is_active'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start_time': startTime,
      'end_time': endTime,
      'is_active': isActive ? 1 : 0,
      'date': date.toIso8601String(),
    };
  }
}
