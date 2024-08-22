part of 'district_cubit.dart';

class DistrictState<T> extends Equatable {
  const DistrictState({
    this.status = CubitStatus.initial,
    this.entity,
    this.selectDistrict,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final List<DistrictEntity>? entity;
  final DistrictEntity? selectDistrict;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    selectDistrict,
    message,
    count,
    errorCode,
  ];

  DistrictState copyWith({
    List<DistrictEntity>? entity,
    DistrictEntity? selectDistrict,
    CubitStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return DistrictState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      selectDistrict: selectDistrict ?? this.selectDistrict,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}