part of 'favorite_cubit.dart';


class FavoriteState<T> extends Equatable {
  const FavoriteState({
    this.status = CubitStatus.initial,
    this.entity,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final List<FavoriteEntity>? entity;
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

  FavoriteState copyWith({
    List<FavoriteEntity>? entity,
    CubitStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return FavoriteState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}