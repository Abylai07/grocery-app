import 'package:abricoz_app/src/domain/usecase/order/order_usecase.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/enums.dart';


class OrderHistoryCubit extends Cubit<BaseState> {
  OrderHistoryCubit(this.orderUseCase) : super(const BaseState());

  final OrderUseCase orderUseCase;

  void fetchOrderHistory() async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await orderUseCase.fetchOrderHistory();

    emit(
      failureOrAuth.fold(
        (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) {
          return BaseState(
            status: CubitStatus.success,
            entity: r,
          );
        }
      ),
    );
  }
}
