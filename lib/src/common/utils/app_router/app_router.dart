import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/product/category_entity.dart';
import '../../../domain/entity/product/sub_category_entity.dart';
import '../../../presentation/view/authorization/code_enter_screen.dart';
import '../../../presentation/view/authorization/sign_in_screen.dart';
import '../../../presentation/view/basket/basket_screen.dart';
import '../../../presentation/view/category/sub_category_screen.dart';
import '../../../presentation/view/favorite/favorite_screen.dart';
import '../../../presentation/view/home/home_screen.dart';
import '../../../presentation/view/index_screen.dart';
import '../../../presentation/view/product/product_screen.dart';
import '../../../presentation/view/profile/profile_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: IndexRoute.page, initial: true, children: [
          AutoRoute(page: HomeRoute.page,),
          AutoRoute(page: BasketRoute.page),
          AutoRoute(page: FavoriteRoute.page),
          AutoRoute(page: ProfileRoute.page),
        ]),
        AutoRoute(page: SubCategoryRoute.page),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: CodeEnterRoute.page),
        AutoRoute(page: ProductRoute.page),
      ];
}
