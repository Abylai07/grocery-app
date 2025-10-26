part of 'basket_bloc.dart';

abstract class BasketEvent {
  const BasketEvent();
}


class RefreshBasket extends BasketEvent {
  const RefreshBasket();
}

class CalculateTotalPrice extends BasketEvent {
  const CalculateTotalPrice();
}

class SetProductById extends BasketEvent {
  const SetProductById(this.model);
  final ProductHiveModel model;
}

class CheckBasketItems extends BasketEvent {
  const CheckBasketItems({this.readyToOrder = false});
  final bool readyToOrder;
}


class DeleteAllBasket extends BasketEvent {
  const DeleteAllBasket();
}
