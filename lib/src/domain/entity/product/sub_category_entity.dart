import 'package:equatable/equatable.dart';

class SubCategoryEntity extends Equatable {
  final int id;
  final int categoryId;
  final String? photoUrl;
  final bool isDiscount;
  final Map<String, String> name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SubCategoryEntity({
    required this.id,
    required this.categoryId,
    required this.photoUrl,
    required this.name,
    this.isDiscount = false,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        categoryId,
        photoUrl,
        name,
        isDiscount,
        createdAt,
        updatedAt,
      ];
}
