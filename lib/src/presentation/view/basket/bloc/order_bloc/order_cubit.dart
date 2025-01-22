import 'package:abricoz_app/src/domain/entity/order/order_entity.dart';
import 'package:abricoz_app/src/domain/usecase/order/order_usecase.dart';
import 'package:abricoz_app/src/domain/usecase/product/product_usecase.dart';
import 'package:abricoz_app/src/domain/usecase/user/sign_in_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enums.dart';
import '../../../../../data/hive/adapter/product_adapter.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.orderUseCase) : super(const OrderState());

  final OrderUseCase orderUseCase;

  void createOrder({
    required int? timeId,
    required int? addressId,
    required List<ProductHiveModel> products,
  }) async {
    emit(const OrderState(status: CubitStatus.loading));

    final productMap = products
        .map((item) => {
              'product_id': item.id,
              'product_quantity': item.basketCount,
            })
        .toList();

    Map<String, dynamic> data = {
      "delivery_interval_id": timeId,
      "payment_type_id": 1,
      "address_id": addressId,
      "delivery_date": DateTime.now().toIso8601String(),
      "products": productMap
    };

    final failureOrAuth = await orderUseCase.createOrder(MapParams(data));

    emit(
      failureOrAuth.fold(
        (l) => OrderState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) => OrderState(
          status: CubitStatus.success,
          entity: r,
        ),
      ),
    );
  }

  void cancelOrder({
    required String orderId,
  }) async {
    emit(const OrderState(status: CubitStatus.loading));

    final failureOrAuth = await orderUseCase.cancelOrder(PathParams(orderId));

    emit(
      failureOrAuth.fold(
        (l) => OrderState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) => const OrderState(
          status: CubitStatus.success,
        ),
      ),
    );
  }
}
