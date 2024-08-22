import 'package:abricoz_app/src/data/hive/adapter/product_adapter.dart';
import 'package:abricoz_app/src/data/models/product/product_model.dart';
import 'package:abricoz_app/src/domain/entity/product/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/hive/hive_database.dart';

part 'basket_button_event.dart';
part 'basket_button_state.dart';

class BasketButtonBloc extends Bloc<BasketButtonEvent, BasketButtonState> {
  BasketButtonBloc(ProductHiveModel? itemInBasket)
      : super(itemInBasket != null
            ? BasketButtonState(
                inBasket: itemInBasket.id != -1,
                count: itemInBasket.basketCount,
                product: itemInBasket,
              )
            : BasketButtonState(inBasket: false, count: 0)) {
    on<AddToBasket>((event, emit) {
      BasketDatabase().addProductFromEntity(event.product as ProductModel);
      emit(BasketButtonState(inBasket: true, count: 1));
    });
    on<IncrementCount>((event, emit) {
      BasketDatabase()
          .changeProductCount(event.productId.toString(), state.count + 1);
      emit(BasketButtonState(inBasket: true, count: state.count + 1));
    });
    on<DecrementCount>((event, emit) {
      BasketDatabase()
          .changeProductCount(event.productId.toString(), state.count - 1);
      emit(BasketButtonState(inBasket: true, count: state.count - 1));
    });
    on<DeleteAtBasket>((event, emit) {
      BasketDatabase().deleteProduct(event.productId.toString());
      emit(BasketButtonState(inBasket: false, count: 0));
    });
  }
}
