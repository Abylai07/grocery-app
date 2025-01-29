// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
//
// import '../../../core/error/failure.dart';
// import '../../../core/usecases/usecase.dart';
// import '../../repository/abstract_order_service_profile.dart';
//
// class PaymentUseCase extends UseCase<Map<String, dynamic>, PaymentParams> {
//   final AbstractOrderServiceRepository repository;
//
//   PaymentUseCase(this.repository);
//
//   @override
//   Future<Either<Failure, Map<String, dynamic>>> call(
//       PaymentParams params) async =>
//       await repository.initHalykPay(params);
// }
//
// class PaymentParams extends Equatable {
//   const PaymentParams({required this.amount,required this.invoiceId});
//
//   final double amount;
//   final String invoiceId;
//
//
//   @override
//   List<Object?> get props => [amount,  invoiceId];
// }