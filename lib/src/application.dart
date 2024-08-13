import 'package:abricoz_app/src/presentation/bloc/nav_bar_bloc.dart';
import 'package:abricoz_app/src/presentation/view/category/bloc/category_cubit.dart';
import 'package:abricoz_app/src/presentation/view/home/bloc/banner_cubit.dart';
import 'package:abricoz_app/src/presentation/view/home/bloc/city_bloc/city_cubit.dart';
import 'package:abricoz_app/src/presentation/view/product/bloc/product_cubit.dart';
import 'package:abricoz_app/src/presentation/view/product/bloc/search_bloc/search_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/app_styles/app_theme.dart';
import 'common/utils/app_router/app_router.dart';
import 'common/utils/l10n/generated/l10n.dart';
import 'common/utils/locale/locale.dart';
import 'get_it_sl.dart';

class Application extends StatelessWidget {
  Application({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NavBarBloc(),
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
        BlocProvider(
          create: (context) => SearchProductCubit(sl()),
        )
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        builder: (context, child) => LocaleBuilder(builder: (context, locale) {
          return MaterialApp.router(
            routerConfig: appRouter.config(),
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
