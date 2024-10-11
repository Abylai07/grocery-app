import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String? firstname;
  final String? lastname;
  final String phone;
  final String? email;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    this.email,
    required this.isEmailVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    firstname,
    lastname,
    phone,
    email,
    isEmailVerified,
    createdAt,
    updatedAt,
  ];
}
