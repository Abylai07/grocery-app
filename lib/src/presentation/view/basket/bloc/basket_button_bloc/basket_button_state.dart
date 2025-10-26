part of 'basket_button_bloc.dart';

class BasketButtonState {
  final bool inBasket;
  final int count;
  final ProductHiveModel? product;

  BasketButtonState({
    required this.inBasket,
    required this.count,
    this.product,
  });
}
