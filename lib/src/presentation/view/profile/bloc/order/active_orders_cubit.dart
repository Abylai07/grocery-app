import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enums.dart';
import '../../../../../domain/usecase/order/order_history_usecase.dart';


class ActiveOrdersCubit extends Cubit<BaseState> {
  ActiveOrdersCubit(this.orderUseCase) : super(const BaseState());

  final OrderHistoryUseCase orderUseCase;

  Future fetchActiveOrders() async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await orderUseCase.fetchActiveOrders();

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
