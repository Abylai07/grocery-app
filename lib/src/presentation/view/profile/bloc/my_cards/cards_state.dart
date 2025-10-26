part of 'cards_cubit.dart';

enum PaymentType { cash, card, none }

extension PaymentTypeX on PaymentType {
  bool get isCash => this == PaymentType.cash;
  bool get isCard => this == PaymentType.card;
  bool get isNone => this == PaymentType.none;
}

class CardsState extends Equatable {
  const CardsState({
    this.status = CubitStatus.initial,
    this.entity,
    this.selectCard,
    this.paymentType = PaymentType.card,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final List<CardEntity>? entity;
  final CardEntity? selectCard;
  final PaymentType paymentType;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
        status,
        entity,
        selectCard,
        paymentType,
        message,
        count,
        errorCode,
      ];

  CardsState copyWith({
    List<CardEntity>? entity,
    CardEntity? selectCard,
    CubitStatus? status,
    PaymentType? paymentType,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return CardsState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      paymentType: paymentType ?? this.paymentType,
      selectCard: selectCard ?? this.selectCard,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
