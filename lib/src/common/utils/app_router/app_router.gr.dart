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
