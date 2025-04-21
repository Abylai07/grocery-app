
import '../../../domain/entity/user/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.firstname,
    super.lastname,
    required super.phone,
    required super.isBanned,
    super.email,
    super.roles,
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
      isBanned: json['is_banned'] == 1,
      roles: (json['roles'] as List)
          .map((role) => RoleEntity.fromJson(role))
          .toList(),
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
      'is_banned': isBanned ? 1 : 0,
      'email': email,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'roles': roles?.map((role) => role.toJson()).toList(),
    };
  }
}
