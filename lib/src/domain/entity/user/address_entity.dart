import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int id;
  final int userId;
  final int districtId;
  final int cityId;
  final num? deliveryPrice;
  final String streetAndHouse;
  final String? apartment;
  final String? entrance;
  final String? floor;
  final String? addressComment;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AddressEntity( {
    required this.id,
    required this.userId,
    required this.districtId,
    required this.cityId,
    required this.streetAndHouse,
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
    districtId,
    cityId,
    streetAndHouse,
    deliveryPrice,
    addressComment,
    apartment,
    entrance,
    floor,
    createdAt,
    updatedAt,
  ];
}
