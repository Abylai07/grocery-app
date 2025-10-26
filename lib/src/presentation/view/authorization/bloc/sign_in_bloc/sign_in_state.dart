
part of 'sign_in_cubit.dart';


/// Cubit statuses initial success error loading
enum SignInStatus {initial, successPhone, successCode, needName, successName, error, errorCode, loading}

extension SignInStatusX on SignInStatus {
  bool get isInitial => this == SignInStatus.initial;
  bool get isSuccessPhone => this == SignInStatus.successPhone;
  bool get isNeedName => this == SignInStatus.needName;
  bool get isSuccessName => this == SignInStatus.successName;
  bool get isSuccessCode => this == SignInStatus.successCode;
  bool get isError => this == SignInStatus.error;
  bool get isErrorCode => this == SignInStatus.errorCode;
  bool get isLoading => this == SignInStatus.loading;
}

class SignInState<T> extends Equatable {
  const SignInState({
    this.status = SignInStatus.initial,
    this.entity,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final SignInStatus status;
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

  SignInState copyWith({
    T? entity,
    SignInStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return SignInState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
