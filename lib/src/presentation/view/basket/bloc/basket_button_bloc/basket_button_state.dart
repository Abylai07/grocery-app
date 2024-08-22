part of 'basket_button_bloc.dart';

class BasketButtonState {
  final bool inBasket;
  final int count;
  final ProductHiveModel? product;
  final List<ProductHiveModel>? allProducts;

  BasketButtonState({
    required this.inBasket,
    this.allProducts,
    required this.count,
    this.product,
  });
}
