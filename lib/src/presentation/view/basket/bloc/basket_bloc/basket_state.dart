part of 'basket_bloc.dart';

class BasketState<T> extends Equatable {
  final num basketSum;
  final ProductHiveModel? product;
    final List<ProductHiveModel>? allProducts;
  final CubitStatus status;
  final CheckCardEntity? entity;
  final String? message;
  final int? errorCode;

  const BasketState({
    this.allProducts,
    this.basketSum = 0,
    this.product,
    this.status = CubitStatus.initial,
    this.entity,
    this.errorCode,
    this.message = '',
  });

  BasketState<T> copyWith({
    num? basketSum,
    ProductHiveModel? product,
    List<ProductHiveModel>? allProducts,
    CubitStatus? status,
    CheckCardEntity? entity,
    String? message,
    int? errorCode,
  }) {
    return BasketState<T>(
      basketSum: basketSum ?? this.basketSum,
      product: product ?? this.product,
      allProducts: allProducts ?? this.allProducts,
      status: status ?? this.status,
      entity: entity ?? this.entity,
      message: message ?? this.message,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object?> get props => [
    basketSum,
    product,
    allProducts,
    status,
    entity,
    message,
    errorCode,
  ];
}
