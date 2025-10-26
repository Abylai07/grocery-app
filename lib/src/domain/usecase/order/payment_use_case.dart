import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../repository/abstract_order_service_profile.dart';

class PaymentUseCase extends UseCase<String, PaymentParams> {
  final AbstractOrderServiceRepository repository;

  PaymentUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(PaymentParams params) async => await repository.getPaymentLink(params);
}

class PaymentParams extends Equatable {
  const PaymentParams({required this.invoiceId});

  final String invoiceId;


  @override
  List<Object?> get props => [invoiceId];
}