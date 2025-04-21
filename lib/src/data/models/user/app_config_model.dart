import '../../../domain/entity/user/app_config_entity.dart';

class AppConfigModel extends AppConfigEntity {
  const AppConfigModel({
    required super.isAppActive,
    required super.minOrderAmount,
    required super.isCashPaymentActive,
    required super.isBankPaymentActive,
  });

  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    return AppConfigModel(
      isAppActive: json['isAppActive'] == 1, // Преобразуем 1/0 в bool
      minOrderAmount: json['minOrderAmount'],
      isCashPaymentActive: json['isCashPaymentActive'] == 1, // Преобразуем 1/0 в bool
      isBankPaymentActive: json['isBankPaymentActive'] == 1, // Преобразуем 1/0 в bool
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isAppActive': isAppActive ? 1 : 0,
      'minOrderAmount': minOrderAmount,
      'isCashPaymentActive': isCashPaymentActive ? 1 : 0,
      'isBankPaymentActive': isBankPaymentActive ? 1 : 0,
    };
  }
}
