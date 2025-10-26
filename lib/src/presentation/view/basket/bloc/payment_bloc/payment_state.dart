
part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  const PaymentState({
    this.status = CubitStatus.initial,
    this.paymentUrl,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final String? paymentUrl;
  final String message;

  @override
  List<Object?> get props => [
    status,
    message,
    paymentUrl,
  ];

  PaymentState copyWith({
    String? paymentUrl,
    CubitStatus? status,
    String? message,
  }) {
    return PaymentState(
      paymentUrl: paymentUrl ?? this.paymentUrl,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
