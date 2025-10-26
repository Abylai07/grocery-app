import 'package:equatable/equatable.dart';

class PointsEntity extends Equatable {
  final List<LocationEntity> data;
  final String? message;
  final int? httpCode;
  final String? status;
  final String apiKey;

  const PointsEntity({
    required this.data,
    this.message,
    this.httpCode,
    this.status,
    required this.apiKey,
  });

  @override
  List<Object?> get props => [data, message, httpCode, status, apiKey];
}

class LocationEntity extends Equatable {
  final int id;
  final int cityId;
  final String latitude;
  final String longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LocationEntity({
    required this.id,
    required this.cityId,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props =>
      [id, cityId, latitude, longitude, createdAt, updatedAt];
}
