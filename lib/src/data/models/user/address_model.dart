
import '../../../domain/entity/user/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.id,
    required super.userId,
    required super.cityId,
    required super.streetAndHouse,
    super.latitude,
    super.longitude,
    super.addressComment,
    super.deliveryPrice,
    super.apartment,
    super.entrance,
    super.floor,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      userId: json['user_id'],
      cityId: json['city_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      deliveryPrice: json['district'] != null ? json['district']['delivery_price'] : null,
      streetAndHouse: json['address_street_and_house'],
      addressComment: json['address_comment'],
      apartment: json['address_apartment'],
      entrance: json['address_entrance'],
      floor: json['address_floor'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'city_id': cityId,
      'delivery_price': deliveryPrice,
      'latitude': latitude,
      'longitude': longitude,
      'address_street_and_house': streetAndHouse,
      'address_apartment': apartment,
      'address_entrance': entrance,
      'address_floor': floor,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
