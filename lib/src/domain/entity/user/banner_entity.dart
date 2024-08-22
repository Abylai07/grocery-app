import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final int id;
  final Map<String, String> imageUrl;
  final int number;
  final Map<String, String> title;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BannerEntity({
    required this.id,
    required this.imageUrl,
    required this.number,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, imageUrl, number, title, createdAt, updatedAt];
}
