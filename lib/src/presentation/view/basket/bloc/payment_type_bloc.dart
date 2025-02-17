import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Define payment types
enum PaymentType { cash, card }

extension PaymentTypeX on PaymentType {
  bool get isCash => this == PaymentType.cash;
  bool get isCard => this == PaymentType.card;
}


// Bloc Events
abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class SelectPaymentType extends PaymentEvent {
  final PaymentType paymentType;

  const SelectPaymentType(this.paymentType);

  @override
  List<Object> get props => [paymentType];
}

// Bloc State
class PaymentTypeState extends Equatable {
  final PaymentType selectedPaymentType;

  const PaymentTypeState({required this.selectedPaymentType});

  @override
  List<Object> get props => [selectedPaymentType];

  int getPaymentTypeId() {
    return selectedPaymentType == PaymentType.cash ? 1 : 2;
  }
}

// Bloc Implementation
class PaymentTypeBloc extends Bloc<PaymentEvent, PaymentTypeState> {
  PaymentTypeBloc() : super(const PaymentTypeState(selectedPaymentType: PaymentType.card)) {
    on<SelectPaymentType>((event, emit) {
      emit(PaymentTypeState(selectedPaymentType: event.paymentType));
    });
  }
}
