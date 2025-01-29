//
// part of 'bank_pay_cubit.dart';
//
// class BankPayState extends Equatable {
//   const BankPayState({
//     this.status = CubitStatus.initial,
//     this.halykEntity,
//     this.kaspiEntity,
//     String? message,
//   }) : message = message ?? '';
//
//   final CubitStatus status;
//   final Map<String, dynamic>? halykEntity;
//   final KaspiPaymentEntity? kaspiEntity;
//   final String message;
//
//   @override
//   List<Object?> get props => [
//     status,
//     message,
//     halykEntity,
//     kaspiEntity,
//   ];
//
//   BankPayState copyWith({
//     Map<String, dynamic>? halykEntity,
//     KaspiPaymentEntity? kaspiEntity,
//     CubitStatus? status,
//     String? message,
//   }) {
//     return BankPayState(
//       halykEntity: halykEntity ?? this.halykEntity,
//       status: status ?? this.status,
//       message: message ?? this.message,
//       kaspiEntity: kaspiEntity ?? this.kaspiEntity,
//     );
//   }
// }
