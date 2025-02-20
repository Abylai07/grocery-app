import 'package:abricoz_app/src/presentation/bloc/nav_bar_bloc.dart';
import 'package:abricoz_app/src/presentation/bloc/remote_config_cubit.dart';
import 'package:abricoz_app/src/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:abricoz_app/src/presentation/view/basket/bloc/basket_bloc/basket_bloc.dart';
import 'package:abricoz_app/src/presentation/view/category/bloc/category_cubit.dart';
import 'package:abricoz_app/src/presentation/view/favorite/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:abricoz_app/src/presentation/view/home/bloc/banner_cubit.dart';
import 'package:abricoz_app/src/presentation/view/home/bloc/city_bloc/city_cubit.dart';
import 'package:abricoz_app/src/presentation/view/product/bloc/search_bloc/search_product_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/address_bloc/address_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/my_cards/cards_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/order/active_orders_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/order/order_history_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/user_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/user_session_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/app_styles/app_theme.dart';
import 'common/utils/app_router/app_router.dart';
import 'common/utils/l10n/generated/l10n.dart';
import 'common/utils/locale/locale.dart';
import 'get_it_sl.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NavBarBloc(),
        ),
        BlocProvider(
          create: (_) => SearchBloc(),
        ),
        BlocProvider(
          create: (_) => UserSessionBloc()..add(LoadUserSession()),
        ),
        BlocProvider<BannerCubit>(
          create: (_) => BannerCubit(sl())..fetchBanners(),
        ),
        BlocProvider<CategoryCubit>(
          create: (_) => CategoryCubit(sl())..fetchCategory(),
        ),
        BlocProvider<CityCubit>(
          create: (_) => CityCubit(sl())..fetchCityList(),
        ),
        BlocProvider<AddressCubit>(
          create: (_) => AddressCubit(sl())..fetchAddress(),
        ),
        BlocProvider<FavoriteCubit>(
          create: (_) => FavoriteCubit(sl())..fetchFavorites(),
        ),
        BlocProvider<CardsCubit>(
          create: (_) => CardsCubit(sl())..fetchMyCards(),
        ),
        BlocProvider<UserCubit>(
          create: (_) => UserCubit(sl()),
        ),
        BlocProvider(
          create: (context) => BasketBloc(sl()),
        ),
        BlocProvider(
          create: (context) => SearchProductCubit(sl()),
        ),
        BlocProvider(
          create: (context) => ActiveOrdersCubit(sl())..fetchActiveOrders(),
        ),
        BlocProvider(
          create: (context) => OrderHistoryCubit(sl()),
        ),
        BlocProvider<RemoteConfigCubit>(
          create: (_) => RemoteConfigCubit()..startWork(),
        ),
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        builder: (context, child) => LocaleBuilder(builder: (context, locale) {
          return MaterialApp.router(
            routerConfig: appRouter.config(
              deepLinkBuilder: (deepLink) {
                return DeepLink.defaultPath;
              },
            ),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: locale,
            supportedLocales: S.delegate.supportedLocales,
            theme: AppTheme.lightTheme,
          );
        }),
      ),
    );
  }
}
