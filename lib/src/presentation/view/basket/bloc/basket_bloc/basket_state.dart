part of 'basket_bloc.dart';

enum BasketStatus { initial, success,  readyToOrder, clearedBasket,  error, loading, orderLoading}

extension BasketStatusX on BasketStatus {
  bool get isInitial => this == BasketStatus.initial;
  bool get isSuccess => this == BasketStatus.success;
  bool get isError => this == BasketStatus.error;
  bool get isLoading => this == BasketStatus.loading;
  bool get isClearedBasket => this == BasketStatus.clearedBasket;
  bool get isReadyToOrder => this == BasketStatus.readyToOrder;
  bool get isOrderLoading => this == BasketStatus.orderLoading;
}
class BasketState extends Equatable {
  final num basketSum;
  final ProductHiveModel? product;
  final List<ProductHiveModel>? allProducts;
  final BasketStatus status;
  final CheckCardEntity? entity;
  final String? message;
  final bool isCartChanged;
  final int? errorCode;

  const BasketState({
    this.allProducts,
    this.basketSum = 0,
    this.isCartChanged = false,
    this.product,
    this.status = BasketStatus.initial,
    this.entity,
    this.errorCode,
    this.message = '',
  });

  BasketState copyWith({
    num? basketSum,
    ProductHiveModel? product,
    List<ProductHiveModel>? allProducts,
    BasketStatus? status,
    bool? isCartChanged,
    CheckCardEntity? entity,
    String? message,
    int? errorCode,
  }) {
    return BasketState(
      basketSum: basketSum ?? this.basketSum,
      product: product ?? this.product,
      allProducts: allProducts ?? this.allProducts,
      status: status ?? this.status,
      isCartChanged: isCartChanged ?? this.isCartChanged,
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
    isCartChanged,
    entity,
    message,
    errorCode,
  ];
}
