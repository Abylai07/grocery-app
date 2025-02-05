// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddOrChangeAddressRoute.name: (routeData) {
      final args = routeData.argsAs<AddOrChangeAddressRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddOrChangeAddressScreen(
          key: args.key,
          address: args.address,
          selectAddress: args.selectAddress,
        ),
      );
    },
    AddressRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddressScreen(),
      );
    },
    BasketRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BasketScreen(),
      );
    },
    CodeEnterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CodeEnterScreen(),
      );
    },
    FavoriteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoriteScreen(),
      );
    },
    HomeNestedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeNestedScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    IndexRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const IndexScreen(),
      );
    },
    InformationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const InformationScreen(),
      );
    },
    MakeOrderRoute.name: (routeData) {
      final args = routeData.argsAs<MakeOrderRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MakeOrderScreen(
          key: args.key,
          products: args.products,
          productSum: args.productSum,
        ),
      );
    },
    MapAddressRoute.name: (routeData) {
      final args = routeData.argsAs<MapAddressRouteArgs>(
          orElse: () => const MapAddressRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MapAddressScreen(
          key: args.key,
          address: args.address,
        ),
      );
    },
    OrderDetailRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrderDetailScreen(
          key: args.key,
          orderId: args.orderId,
        ),
      );
    },
    OrderHistoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrderHistoryScreen(),
      );
    },
    PaymentRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PaymentScreen(
          key: args.key,
          orderInfo: args.orderInfo,
        ),
      );
    },
    ProductRoute.name: (routeData) {
      final args = routeData.argsAs<ProductRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductScreen(
          key: args.key,
          subCategory: args.subCategory,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    SearchedProductRoute.name: (routeData) {
      final args = routeData.argsAs<SearchedProductRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SearchedProductScreen(
          key: args.key,
          searchHint: args.searchHint,
        ),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInScreen(),
      );
    },
    SubCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<SubCategoryRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SubCategoryScreen(
          key: args.key,
          category: args.category,
        ),
      );
    },
    UserInfoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserInfoScreen(),
      );
    },
    WebViewRoute.name: (routeData) {
      final args = routeData.argsAs<WebViewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WebViewScreen(
          key: args.key,
          title: args.title,
          url: args.url,
        ),
      );
    },
  };
}

/// generated route for
/// [AddOrChangeAddressScreen]
class AddOrChangeAddressRoute
    extends PageRouteInfo<AddOrChangeAddressRouteArgs> {
  AddOrChangeAddressRoute({
    Key? key,
    AddressEntity? address,
    required YandexAddress selectAddress,
    List<PageRouteInfo>? children,
  }) : super(
          AddOrChangeAddressRoute.name,
          args: AddOrChangeAddressRouteArgs(
            key: key,
            address: address,
            selectAddress: selectAddress,
          ),
          initialChildren: children,
        );

  static const String name = 'AddOrChangeAddressRoute';

  static const PageInfo<AddOrChangeAddressRouteArgs> page =
      PageInfo<AddOrChangeAddressRouteArgs>(name);
}

class AddOrChangeAddressRouteArgs {
  const AddOrChangeAddressRouteArgs({
    this.key,
    this.address,
    required this.selectAddress,
  });

  final Key? key;

  final AddressEntity? address;

  final YandexAddress selectAddress;

  @override
  String toString() {
    return 'AddOrChangeAddressRouteArgs{key: $key, address: $address, selectAddress: $selectAddress}';
  }
}

/// generated route for
/// [AddressScreen]
class AddressRoute extends PageRouteInfo<void> {
  const AddressRoute({List<PageRouteInfo>? children})
      : super(
          AddressRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BasketScreen]
class BasketRoute extends PageRouteInfo<void> {
  const BasketRoute({List<PageRouteInfo>? children})
      : super(
          BasketRoute.name,
          initialChildren: children,
        );

  static const String name = 'BasketRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CodeEnterScreen]
class CodeEnterRoute extends PageRouteInfo<void> {
  const CodeEnterRoute({List<PageRouteInfo>? children})
      : super(
          CodeEnterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CodeEnterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoriteScreen]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeNestedScreen]
class HomeNestedRoute extends PageRouteInfo<void> {
  const HomeNestedRoute({List<PageRouteInfo>? children})
      : super(
          HomeNestedRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeNestedRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [IndexScreen]
class IndexRoute extends PageRouteInfo<void> {
  const IndexRoute({List<PageRouteInfo>? children})
      : super(
          IndexRoute.name,
          initialChildren: children,
        );

  static const String name = 'IndexRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InformationScreen]
class InformationRoute extends PageRouteInfo<void> {
  const InformationRoute({List<PageRouteInfo>? children})
      : super(
          InformationRoute.name,
          initialChildren: children,
        );

  static const String name = 'InformationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MakeOrderScreen]
class MakeOrderRoute extends PageRouteInfo<MakeOrderRouteArgs> {
  MakeOrderRoute({
    Key? key,
    required List<ProductHiveModel> products,
    required num productSum,
    List<PageRouteInfo>? children,
  }) : super(
          MakeOrderRoute.name,
          args: MakeOrderRouteArgs(
            key: key,
            products: products,
            productSum: productSum,
          ),
          initialChildren: children,
        );

  static const String name = 'MakeOrderRoute';

  static const PageInfo<MakeOrderRouteArgs> page =
      PageInfo<MakeOrderRouteArgs>(name);
}

class MakeOrderRouteArgs {
  const MakeOrderRouteArgs({
    this.key,
    required this.products,
    required this.productSum,
  });

  final Key? key;

  final List<ProductHiveModel> products;

  final num productSum;

  @override
  String toString() {
    return 'MakeOrderRouteArgs{key: $key, products: $products, productSum: $productSum}';
  }
}

/// generated route for
/// [MapAddressScreen]
class MapAddressRoute extends PageRouteInfo<MapAddressRouteArgs> {
  MapAddressRoute({
    Key? key,
    AddressEntity? address,
    List<PageRouteInfo>? children,
  }) : super(
          MapAddressRoute.name,
          args: MapAddressRouteArgs(
            key: key,
            address: address,
          ),
          initialChildren: children,
        );

  static const String name = 'MapAddressRoute';

  static const PageInfo<MapAddressRouteArgs> page =
      PageInfo<MapAddressRouteArgs>(name);
}

class MapAddressRouteArgs {
  const MapAddressRouteArgs({
    this.key,
    this.address,
  });

  final Key? key;

  final AddressEntity? address;

  @override
  String toString() {
    return 'MapAddressRouteArgs{key: $key, address: $address}';
  }
}

/// generated route for
/// [OrderDetailScreen]
class OrderDetailRoute extends PageRouteInfo<OrderDetailRouteArgs> {
  OrderDetailRoute({
    Key? key,
    required int orderId,
    List<PageRouteInfo>? children,
  }) : super(
          OrderDetailRoute.name,
          args: OrderDetailRouteArgs(
            key: key,
            orderId: orderId,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderDetailRoute';

  static const PageInfo<OrderDetailRouteArgs> page =
      PageInfo<OrderDetailRouteArgs>(name);
}

class OrderDetailRouteArgs {
  const OrderDetailRouteArgs({
    this.key,
    required this.orderId,
  });

  final Key? key;

  final int orderId;

  @override
  String toString() {
    return 'OrderDetailRouteArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [OrderHistoryScreen]
class OrderHistoryRoute extends PageRouteInfo<void> {
  const OrderHistoryRoute({List<PageRouteInfo>? children})
      : super(
          OrderHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderHistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PaymentScreen]
class PaymentRoute extends PageRouteInfo<PaymentRouteArgs> {
  PaymentRoute({
    Key? key,
    required OrderEntity orderInfo,
    List<PageRouteInfo>? children,
  }) : super(
          PaymentRoute.name,
          args: PaymentRouteArgs(
            key: key,
            orderInfo: orderInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentRoute';

  static const PageInfo<PaymentRouteArgs> page =
      PageInfo<PaymentRouteArgs>(name);
}

class PaymentRouteArgs {
  const PaymentRouteArgs({
    this.key,
    required this.orderInfo,
  });

  final Key? key;

  final OrderEntity orderInfo;

  @override
  String toString() {
    return 'PaymentRouteArgs{key: $key, orderInfo: $orderInfo}';
  }
}

/// generated route for
/// [ProductScreen]
class ProductRoute extends PageRouteInfo<ProductRouteArgs> {
  ProductRoute({
    Key? key,
    required SubCategoryEntity subCategory,
    List<PageRouteInfo>? children,
  }) : super(
          ProductRoute.name,
          args: ProductRouteArgs(
            key: key,
            subCategory: subCategory,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static const PageInfo<ProductRouteArgs> page =
      PageInfo<ProductRouteArgs>(name);
}

class ProductRouteArgs {
  const ProductRouteArgs({
    this.key,
    required this.subCategory,
  });

  final Key? key;

  final SubCategoryEntity subCategory;

  @override
  String toString() {
    return 'ProductRouteArgs{key: $key, subCategory: $subCategory}';
  }
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SearchedProductScreen]
class SearchedProductRoute extends PageRouteInfo<SearchedProductRouteArgs> {
  SearchedProductRoute({
    Key? key,
    required SearchHintEntity searchHint,
    List<PageRouteInfo>? children,
  }) : super(
          SearchedProductRoute.name,
          args: SearchedProductRouteArgs(
            key: key,
            searchHint: searchHint,
          ),
          initialChildren: children,
        );

  static const String name = 'SearchedProductRoute';

  static const PageInfo<SearchedProductRouteArgs> page =
      PageInfo<SearchedProductRouteArgs>(name);
}

class SearchedProductRouteArgs {
  const SearchedProductRouteArgs({
    this.key,
    required this.searchHint,
  });

  final Key? key;

  final SearchHintEntity searchHint;

  @override
  String toString() {
    return 'SearchedProductRouteArgs{key: $key, searchHint: $searchHint}';
  }
}

/// generated route for
/// [SignInScreen]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SubCategoryScreen]
class SubCategoryRoute extends PageRouteInfo<SubCategoryRouteArgs> {
  SubCategoryRoute({
    Key? key,
    required CategoryEntity category,
    List<PageRouteInfo>? children,
  }) : super(
          SubCategoryRoute.name,
          args: SubCategoryRouteArgs(
            key: key,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'SubCategoryRoute';

  static const PageInfo<SubCategoryRouteArgs> page =
      PageInfo<SubCategoryRouteArgs>(name);
}

class SubCategoryRouteArgs {
  const SubCategoryRouteArgs({
    this.key,
    required this.category,
  });

  final Key? key;

  final CategoryEntity category;

  @override
  String toString() {
    return 'SubCategoryRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [UserInfoScreen]
class UserInfoRoute extends PageRouteInfo<void> {
  const UserInfoRoute({List<PageRouteInfo>? children})
      : super(
          UserInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserInfoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WebViewScreen]
class WebViewRoute extends PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    Key? key,
    required String title,
    required String url,
    List<PageRouteInfo>? children,
  }) : super(
          WebViewRoute.name,
          args: WebViewRouteArgs(
            key: key,
            title: title,
            url: url,
          ),
          initialChildren: children,
        );

  static const String name = 'WebViewRoute';

  static const PageInfo<WebViewRouteArgs> page =
      PageInfo<WebViewRouteArgs>(name);
}

class WebViewRouteArgs {
  const WebViewRouteArgs({
    this.key,
    required this.title,
    required this.url,
  });

  final Key? key;

  final String title;

  final String url;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, title: $title, url: $url}';
  }
}
