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
      final args = routeData.argsAs<AddOrChangeAddressRouteArgs>(
          orElse: () => const AddOrChangeAddressRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddOrChangeAddressScreen(
          key: args.key,
          address: args.address,
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
  };
}

/// generated route for
/// [AddOrChangeAddressScreen]
class AddOrChangeAddressRoute
    extends PageRouteInfo<AddOrChangeAddressRouteArgs> {
  AddOrChangeAddressRoute({
    Key? key,
    AddressEntity? address,
    List<PageRouteInfo>? children,
  }) : super(
          AddOrChangeAddressRoute.name,
          args: AddOrChangeAddressRouteArgs(
            key: key,
            address: address,
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
  });

  final Key? key;

  final AddressEntity? address;

  @override
  String toString() {
    return 'AddOrChangeAddressRouteArgs{key: $key, address: $address}';
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
