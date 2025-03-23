import 'package:equatable/equatable.dart';

class AppConfigEntity extends Equatable {
  final bool isAppActive;
  final int minOrderAmount;
  final bool isCashPaymentActive;

  const AppConfigEntity({
    required this.isAppActive,
    required this.minOrderAmount,
    required this.isCashPaymentActive,
  });

  @override
  List<Object> get props => [isAppActive, minOrderAmount, isCashPaymentActive];
}
