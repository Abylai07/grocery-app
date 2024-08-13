import 'package:equatable/equatable.dart';

import '../../common/enums.dart';

class BaseState<T> extends Equatable {
  const BaseState({
    this.status = CubitStatus.initial,
    this.entity,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final T? entity;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    message,
    count,
    errorCode,
  ];

  BaseState copyWith({
    T? entity,
    CubitStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return BaseState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
