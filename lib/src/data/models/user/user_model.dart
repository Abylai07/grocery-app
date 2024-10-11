
import '../../../domain/entity/user/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.firstname,
    super.lastname,
    required super.phone,
    super.email,
    required super.isEmailVerified,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: json['phone'],
      email: json['email'],
      isEmailVerified: json['email_verified_at'] != null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'email': email,
      'email_verified_at': isEmailVerified ? updatedAt.toIso8601String() : null,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
