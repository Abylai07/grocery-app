part of 'delivery_time_cubit.dart';


class DeliveryTimeState<T> extends Equatable {
  const DeliveryTimeState({
    this.status = CubitStatus.initial,
    this.entity,
    this.selectTime,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final List<DeliveryTimeEntity>? entity;
  final DeliveryTimeEntity? selectTime;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    selectTime,
    message,
    count,
    errorCode,
  ];

  DeliveryTimeState copyWith({
    List<DeliveryTimeEntity>? entity,
    DeliveryTimeEntity? selectTime,
    CubitStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return DeliveryTimeState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      selectTime: selectTime ?? this.selectTime,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}