import 'package:equatable/equatable.dart';

class AppConfigEntity extends Equatable {
  final bool isAppActive;
  final int minOrderAmount;
  final bool isCashPaymentActive;
  final bool isBankPaymentActive;

  const AppConfigEntity({
    required this.isAppActive,
    required this.minOrderAmount,
    required this.isCashPaymentActive,
    required this.isBankPaymentActive,
  });

  @override
  List<Object> get props => [isAppActive, minOrderAmount, isCashPaymentActive, isBankPaymentActive];
}
