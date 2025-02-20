part of 'order_cubit.dart';


class OrderState<T> extends Equatable {
  const OrderState({
    this.status = CubitStatus.initial,
    this.entity,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final int? entity;
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

  OrderState copyWith({
    int? entity,
    CubitStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return OrderState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}