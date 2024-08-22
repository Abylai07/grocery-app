import 'package:abricoz_app/src/domain/entity/product/product_entity.dart';
import 'package:abricoz_app/src/domain/entity/product/search_hint_entity.dart';
import 'package:abricoz_app/src/domain/usecase/product/product_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../domain/usecase/user/sign_in_usecase.dart';

part 'search_product_state.dart';

class SearchProductCubit extends Cubit<SearchProductState> {
  final PagingController<int, ProductEntity> pagingController =
      PagingController(firstPageKey: 1);
  final ProductUseCase productUseCase;

  SearchProductCubit(this.productUseCase) : super(const SearchProductState()) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchProduct(pageKey, currentSearchQuery);
    });
  }

  String currentSearchQuery = '';
  int currentId = 1;
  List<ProductEntity> initialResults = [];

  Future<void> _fetchProduct(int pageKey, String searchQuery) async {
    final failureOrAuth = await productUseCase.fetchProducts(
      MapParams(
        searchQuery.isEmpty
            ? {
                'perPage': 20,
                'page': pageKey,
                'subcategory_id[]': currentId,
              }
            : {'name': searchQuery},
      ),
    );

    emit(
      failureOrAuth.fold(
        (l) {
          pagingController.error = l.message;
          return SearchProductState(
            status: SearchStatus.error,
            message: l.message,
          );
        },
        (r) {
          if (pageKey == 1 && searchQuery.isEmpty && initialResults.isEmpty) {
            initialResults = r;
          }
          if (r.isEmpty || searchQuery.isNotEmpty) {
            pagingController.appendLastPage(r);
          } else {
            final nextPageKey = pageKey + 1;
            // r.removeWhere((element) => pagingController.itemList?.contains(element) ?? false);
            pagingController.appendPage(r, nextPageKey);
          }

          return SearchProductState(
            status: SearchStatus.success,
            entity: r,
          );
        },
      ),
    );
  }


  void fetchSearchHint(String hint) async {
    emit(const SearchProductState(status: SearchStatus.loading));

    final failureOrAuth = await productUseCase.fetchSearchHint(MapParams({'name': hint}));

    emit(
      failureOrAuth.fold(
              (l) => SearchProductState(
            status: SearchStatus.error,
            message: l.message,
          ),
              (r) {
            return SearchProductState(
              status: SearchStatus.successHint,
              searchHints: r,
            );
          }
      ),
    );
  }

  void searchItems(String query) {
    currentSearchQuery = query;
    if(!state.status.isSearchSubmit){
      emit(state.copyWith(status: SearchStatus.searchSubmit));
    }
    if (query.isEmpty) {
      pagingController.refresh();
      _restoreInitialResults();
    } else {
      pagingController.refresh();
    }
  }

  void _restoreInitialResults() {
    pagingController.itemList = initialResults;
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
