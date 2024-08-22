import 'package:equatable/equatable.dart';

class DistrictEntity extends Equatable {
  final int id;
  final String name;
  final int deliveryPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DistrictEntity({
    required this.id,
    required this.name,
    required this.deliveryPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, deliveryPrice, createdAt, updatedAt];
}
