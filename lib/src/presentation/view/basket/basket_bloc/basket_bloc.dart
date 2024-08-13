import 'package:abricoz_app/src/data/hive/adapter/product_adapter.dart';
import 'package:abricoz_app/src/data/models/product/product_model.dart';
import 'package:abricoz_app/src/domain/entity/product/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/hive/hive_database.dart';

class BasketEvent {}

class AddToBasket extends BasketEvent {
  final ProductEntity product;
  AddToBasket(this.product);
}

class IncrementCount extends BasketEvent {
  final ProductEntity product;
  IncrementCount(this.product);
}

class DecrementCount extends BasketEvent {
  final ProductEntity product;
  DecrementCount(this.product);
}

class DeleteAtBasket extends BasketEvent {
  final ProductEntity product;
  DeleteAtBasket(this.product);
}

class BasketState {
  final bool inBasket;
  final int count;
  final ProductHiveModel? product;

  BasketState({required this.inBasket, required this.count, this.product});
}

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc(ProductHiveModel itemInBasket)
      : super(BasketState(
          inBasket: itemInBasket.id != -1,
          count: itemInBasket.basketCount,
          product: itemInBasket,
        )) {
    on<AddToBasket>((event, emit) {
      BasketDatabase().addProductFromEntity(event.product as ProductModel);
      emit(BasketState(inBasket: true, count: 1));
    });
    on<IncrementCount>((event, emit) {
      BasketDatabase()
          .changeProductCount(event.product.id.toString(), state.count + 1);
      emit(BasketState(inBasket: true, count: state.count + 1));
    });
    on<DecrementCount>((event, emit) {
      BasketDatabase()
          .changeProductCount(event.product.id.toString(), state.count - 1);
      emit(BasketState(inBasket: true, count: state.count - 1));
    });
    on<DeleteAtBasket>((event, emit) {
      BasketDatabase().deleteProduct(event.product.id.toString());
      emit(BasketState(inBasket: false, count: 0));
    });
  }
}
