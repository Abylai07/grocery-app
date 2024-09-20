import 'package:abricoz_app/src/domain/entity/order/delivery_time_entity.dart';
import 'package:abricoz_app/src/domain/usecase/order/delivery_time_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enums.dart';

part 'delivery_time_state.dart';

class DeliveryTimeCubit extends Cubit<DeliveryTimeState> {
  DeliveryTimeCubit(this.deliveryTimeUseCase) : super(const DeliveryTimeState());

  final DeliveryTimeUseCase deliveryTimeUseCase;

  void fetchDeliveryTime() async {
    emit(const DeliveryTimeState(status: CubitStatus.loading));

    final failureOrAuth = await deliveryTimeUseCase(null);

    emit(
      failureOrAuth.fold(
        (l) => DeliveryTimeState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) => DeliveryTimeState(
          status: CubitStatus.success,
          entity: r,
        ),
      ),
    );
  }

  selectDeliveryTime(DeliveryTimeEntity? city) {
    emit(state.copyWith(selectTime: city));
  }
}
