// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// part 'bank_pay_state.dart';
//
// class PaymentCubit extends Cubit<BankPayState> {
//   PaymentCubit(
//       this.halykPay,
//       this.kaspiPay,
//       ) : super(const BankPayState());
//   final HalykPayUseCase halykPay;
//
//   Future<bool> initHalyk({
//     required BuildContext context,
//     required String invoiceId,
//     required double amount,
//   }) async {
//     emit(const BankPayState(status: CubitStatus.loading));
//
//     final failureOrOrder = await halykPay(
//       PaymentParams(invoiceId: invoiceId, amount: amount)
//     );
//
//     emit(
//       failureOrOrder.fold(
//               (l) => BankPayState(
//             status: CubitStatus.error,
//             message: l.message,
//           ), (r) {
//         return BankPayState(
//           status: CubitStatus.success,
//           halykEntity: r,
//         );
//       }),
//     );
//     return failureOrOrder.isRight();
//   }
//
//   Future<bool> initKaspi({
//     required String invoiceId,
//   }) async {
//     emit(const BankPayState(status: CubitStatus.loading));
//
//     final failureOrOrder = await kaspiPay(
//         PaymentParams(invoiceId: invoiceId, amount: 0)
//     );
//     emit(
//       failureOrOrder.fold(
//               (l) => BankPayState(
//             status: CubitStatus.error,
//             message: l.message,
//           ), (r) {
//         return BankPayState(
//           status: CubitStatus.success,
//           kaspiEntity: r,
//         );
//       }),
//     );
//     return failureOrOrder.isRight();
//   }
// }