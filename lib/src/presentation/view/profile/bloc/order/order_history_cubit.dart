import 'package:abricoz_app/src/domain/entity/order/order_history_entity.dart';
import 'package:abricoz_app/src/domain/usecase/product/product_usecase.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../common/enums.dart';
import '../../../../../domain/usecase/order/order_history_usecase.dart';
import '../../../../../domain/usecase/user/sign_in_usecase.dart';

class OrderHistoryCubit extends Cubit<BaseState> {
  final PagingController<int, OrderHistoryEntity> pagingController =
  PagingController(firstPageKey: 1);
  final OrderHistoryUseCase _useCase;

  OrderHistoryCubit(this._useCase) : super(const BaseState()) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }


  Future<void> _fetchPage(int pageKey) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final failureOrAuth = await _useCase.fetchOrderHistory(MapParams(
        {
          'perPage': 20,
          'page': pageKey,
        }
    ),
    );

    emit(
      failureOrAuth.fold(
            (l) {
          pagingController.error = l.message;
          return BaseState(
            status: CubitStatus.error,
            message: l.message,
          );
        },
            (r) {
          if (r.totalItems <= r.currentPage) {
            pagingController.appendLastPage(r.orders);
          } else {
            final nextPageKey = pageKey + 1;
            // r.removeWhere((element) => pagingController.itemList?.contains(element) ?? false);
            pagingController.appendPage(r.orders, nextPageKey);
          }

          return BaseState(
            status: CubitStatus.success,
            entity: r,
          );
        },
      ),
    );
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }

  Future fetchOrderById(int id) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await _useCase.fetchOrderById(PathParams(id.toString()));

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

// class OrderHistoryCubit extends Cubit<BaseState> {
//   OrderHistoryCubit(this.orderUseCase) : super(const BaseState());
//
//   final OrderHistoryUseCase orderUseCase;
//
//   Future fetchOrderHistory() async {
//     emit(const BaseState(status: CubitStatus.loading));
//
//     final failureOrAuth = await orderUseCase.fetchOrderHistory();
//
//     emit(
//       failureOrAuth.fold(
//         (l) => BaseState(
//           status: CubitStatus.error,
//           message: l.message,
//         ),
//         (r) {
//           return BaseState(
//             status: CubitStatus.success,
//             entity: r,
//           );
//         }
//       ),
//     );
//   }
//
//
// }
