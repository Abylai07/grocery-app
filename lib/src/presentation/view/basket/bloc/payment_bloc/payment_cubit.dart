import 'package:abricoz_app/src/domain/usecase/order/payment_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enums.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(
      this.paymentUseCase,
      ) : super(const PaymentState());
  final PaymentUseCase paymentUseCase;

  Future<bool> getPaymentLink(int invoiceId) async {
    emit(const PaymentState(status: CubitStatus.loading));

    final failureOrOrder = await paymentUseCase(
      PaymentParams(invoiceId: invoiceId.toString())
    );

    emit(
      failureOrOrder.fold(
              (l) => PaymentState(
            status: CubitStatus.error,
            message: l.message,
          ), (r) {
        return PaymentState(
          status: CubitStatus.success,
          paymentUrl: r,
        );
      }),
    );
    return failureOrOrder.isRight();
  }
}