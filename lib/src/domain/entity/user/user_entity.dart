import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String? firstname;
  final String? lastname;
  final String phone;
  final String? email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<RoleEntity>? roles;

  const UserEntity({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    this.email,
    required this.createdAt,
    required this.updatedAt,
    this.roles,
  });

  @override
  List<Object?> get props => [
    id,
    firstname,
    lastname,
    phone,
    email,
    roles,
    createdAt,
    updatedAt,
  ];
}


class RoleEntity {
  final int id;
  final String name;
  final String guardName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PivotModel pivot;

  RoleEntity({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory RoleEntity.fromJson(Map<String, dynamic> json) {
    return RoleEntity(
      id: json['id'],
      name: json['name'],
      guardName: json['guard_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      pivot: PivotModel.fromJson(json['pivot']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'guard_name': guardName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'pivot': pivot.toJson(),
    };
  }
}

class PivotModel {
  final String modelType;
  final int modelId;
  final int roleId;

  PivotModel({
    required this.modelType,
    required this.modelId,
    required this.roleId,
  });

  factory PivotModel.fromJson(Map<String, dynamic> json) {
    return PivotModel(
      modelType: json['model_type'],
      modelId: json['model_id'],
      roleId: json['role_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model_type': modelType,
      'model_id': modelId,
      'role_id': roleId,
    };
  }
}

