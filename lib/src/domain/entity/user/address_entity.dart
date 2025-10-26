import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int id;
  final int userId;
  final int cityId;
  final num? deliveryPrice;
  final String streetAndHouse;
  final String? latitude;
  final String? longitude;
  final String? apartment;
  final String? entrance;
  final String? floor;
  final String? addressComment;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AddressEntity( {
    required this.id,
    required this.userId,
    required this.cityId,
    required this.streetAndHouse,
    this.latitude,
    this.longitude,
    this.deliveryPrice,
    this.addressComment,
    this.apartment,
    this.entrance,
    this.floor,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    cityId,
    streetAndHouse,
    deliveryPrice,
    addressComment,
    latitude,
    longitude,
    apartment,
    entrance,
    floor,
    createdAt,
    updatedAt,
  ];
}
