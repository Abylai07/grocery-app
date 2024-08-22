part of 'address_cubit.dart';


class AddressState<T> extends Equatable {
  const AddressState({
    this.status = CubitStatus.initial,
    this.entity,
    this.selectAddress,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final List<AddressEntity>? entity;
  final AddressEntity? selectAddress;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    selectAddress,
    message,
    count,
    errorCode,
  ];

  AddressState copyWith({
    List<AddressEntity>? entity,
    AddressEntity? selectDistrict,
    CubitStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return AddressState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      selectAddress: selectDistrict ?? this.selectAddress,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}