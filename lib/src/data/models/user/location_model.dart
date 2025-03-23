import '../../../domain/entity/user/location_entity.dart';

class PointsModel extends PointsEntity {
  const PointsModel({
    required super.data,
    super.message,
    super.httpCode,
    super.status,
    required super.apiKey,
  });

  factory PointsModel.fromJson(Map<String, dynamic> json) {
    return PointsModel(
      data:
          (json['data'] as List).map((e) => LocationModel.fromJson(e)).toList(),
      message: json['message'],
      httpCode: json['http_code'],
      status: json['status'],
      apiKey: json['api_key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'data': data.map((e) => e.toJson()).toList(),
      'message': message,
      'http_code': httpCode,
      'status': status,
      'api_key': apiKey,
    };
  }
}

class LocationModel extends LocationEntity {
  const LocationModel({
    required int id,
    required int cityId,
    required String latitude,
    required String longitude,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          cityId: cityId,
          latitude: latitude,
          longitude: longitude,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as int,
      cityId: json['city_id'] as int,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city_id': cityId,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
