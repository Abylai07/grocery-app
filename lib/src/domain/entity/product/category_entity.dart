import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String? photoUrl;
  final String? mobileUrl;
  final Map<String, String> name;
  final int? forwardSubcategoryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryEntity({
    required this.id,
    required this.photoUrl,
    this.mobileUrl,
    this.forwardSubcategoryId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    photoUrl,
    mobileUrl,
    forwardSubcategoryId,
    name,
    createdAt,
    updatedAt,
  ];
}
