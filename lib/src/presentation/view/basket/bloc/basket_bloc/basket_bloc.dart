import 'package:grocery_app/src/data/hive/adapter/product_adapter.dart';
import 'package:grocery_app/src/domain/entity/order/check_card_entity.dart';
import 'package:grocery_app/src/domain/usecase/order/check_basket_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/hive/hive_database.dart';
import '../../../../../domain/usecase/user/sign_in_usecase.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc(this.useCase) : super(const BasketState()) {
    on<RefreshBasket>((event, emit) {
      List<ProductHiveModel> list = BasketDatabase().getAllProducts();
      emit(BasketState(
        basketSum: _calculatePrice(list),
        allProducts: list,
      ));
    });

    on<DeleteAllBasket>((event, emit) {
      BasketDatabase().clearBasket();
      emit(const BasketState(
          status: BasketStatus.clearedBasket, allProducts: []));
    });

    on<CheckBasketItems>(_onCheckBasket);
  }
  final CheckBasketUseCase useCase;

  Future<void> _onCheckBasket(
      CheckBasketItems event, Emitter<BasketState> emit) async {
    emit(state.copyWith(
        status: event.readyToOrder
            ? BasketStatus.orderLoading
            : BasketStatus.loading));

    List<ProductHiveModel> list = BasketDatabase().getAllProducts();

    if (list.isEmpty) {
      emit(state.copyWith(status: BasketStatus.initial));
      return;
    }
    list.removeWhere((item) => item.basketCount < 1 || item.isActive != true);

    final data = list
        .map((item) => {
              'product_id': item.id,
              'product_quantity': item.basketCount,
            })
        .toList();

    final failureOrAuth = await useCase(MapParams({"products": data}));

    emit(
      await failureOrAuth.fold(
        (l) => BasketState(
          status: BasketStatus.error,
          message: l.message,
          allProducts: list,
          basketSum: _calculatePrice(list),
        ),
        (r) async {
          list.removeWhere((element) =>
              r.products.any((item) => item.id == element.id) == false);

          // Обновляем локальный список на основе данных от бэка
          final updatedList = list.map((localItem) {
            try {
              final newProduct = r.products.firstWhere(
                (product) => product.id == localItem.id,
              );

              // Возвращаем обновленный элемент с новыми данными от бэка
              return localItem.copyWith(
                basketCount:
                    newProduct.productQuantity ?? localItem.basketCount,
                price: newProduct.price.toDouble(),
                discount: newProduct.discount?.toDouble(),
                priceWithDiscount: newProduct.priceWithDiscount?.toDouble(),
                photoUrl: newProduct.photoUrl,
                weight: newProduct.weight,
                isActive: newProduct.isActive,
                availableQuantity: newProduct.availableQuantity,
              );
            } catch (e) {
              print('Error in basket_bloc.dart: $e');
              return localItem;
            }
          }).toList();

          updatedList.removeWhere((item) => item.basketCount < 1);

          await BasketDatabase().clearBasket();
          await BasketDatabase().addProducts(updatedList);

          return BasketState(
              status: event.readyToOrder
                  ? BasketStatus.readyToOrder
                  : BasketStatus.success,
              entity: r,
              allProducts: updatedList,
              basketSum: r.totalPrice.toInt(),
              isCartChanged: r.inactivatedProducts.isNotEmpty ||
                  r.shortagedProducts.isNotEmpty);
        },
      ),
    );
  }

  _calculatePrice(List<ProductHiveModel> list) {
    num totalSum = 0;
    for (final item in list) {
      num itemSum =
          (item.priceWithDiscount != null && item.priceWithDiscount! > 0
                  ? item.priceWithDiscount!
                  : item.price) *
              item.basketCount;
      totalSum = totalSum + itemSum;
    }
    return totalSum.toInt();
  }
}
