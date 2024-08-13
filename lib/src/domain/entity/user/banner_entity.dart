import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final int id;
  final Map<String, String> imageUrl;
  final int number;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BannerEntity({
    required this.id,
    required this.imageUrl,
    required this.number,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, imageUrl, number, createdAt, updatedAt];
}
