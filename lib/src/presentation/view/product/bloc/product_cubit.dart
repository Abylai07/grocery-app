import 'package:abricoz_app/src/domain/entity/product/product_entity.dart';
import 'package:abricoz_app/src/domain/usecase/product/product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../common/enums.dart';
import '../../../../domain/usecase/user/sign_in_usecase.dart';
import '../../../bloc/base_state.dart';

class ProductsCubit extends Cubit<BaseState> {
  final PagingController<int, ProductEntity> pagingController =
      PagingController(firstPageKey: 1);
  final ProductUseCase productUseCase;

  ProductsCubit(this.productUseCase) : super(const BaseState()) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, _currentId);
    });
  }

  int _currentId = 1;

  Future<void> _fetchPage(int pageKey, int id) async {
    emit(state.copyWith(status: CubitStatus.loading));
    final failureOrAuth = await productUseCase.fetchProducts(MapParams(
        {
          'perPage': 20,
          'page': pageKey,
          'subcategory_id[]': id,
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
            pagingController.appendLastPage(r.products);
          } else {
            final nextPageKey = pageKey + 1;
            // r.removeWhere((element) => pagingController.itemList?.contains(element) ?? false);
            pagingController.appendPage(r.products, nextPageKey);
          }

          return BaseState(
            status: CubitStatus.success,
            entity: r,
          );
        },
      ),
    );
  }

  void setCategoryId(int id) {
    _currentId = id;
  }


  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
