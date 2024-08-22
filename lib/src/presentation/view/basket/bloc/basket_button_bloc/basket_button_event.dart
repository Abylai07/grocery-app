part of 'basket_button_bloc.dart';

abstract class BasketButtonEvent {
  const BasketButtonEvent();
}

class SetProductById extends BasketButtonEvent {
  const SetProductById(this.model);
  final ProductHiveModel model;
}


class AddToBasket extends BasketButtonEvent {
  const AddToBasket(this.product);
  final ProductEntity product;
}

class IncrementCount extends BasketButtonEvent {
  final int productId;
  const IncrementCount(this.productId);
}

class DecrementCount extends BasketButtonEvent {
  final int productId;
  const DecrementCount(this.productId);
}

class DeleteAtBasket extends BasketButtonEvent {
  final int productId;
  const DeleteAtBasket(this.productId);
}