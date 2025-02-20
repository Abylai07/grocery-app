import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/presentation/view/basket/bloc/basket_bloc/basket_bloc.dart';
import 'package:abricoz_app/src/presentation/view/basket/bloc/basket_button_bloc/basket_button_bloc.dart';
import 'package:abricoz_app/src/presentation/view/favorite/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_styles/assets.dart';
import '../../../common/app_styles/colors.dart';
import '../../../common/app_styles/text_styles.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../data/hive/adapter/product_adapter.dart';
import '../product/widgets/product_loading_widget.dart';
import '../product/widgets/product_widget.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).favorite),
      ),
      body: BlocBuilder<BasketBloc, BasketState>(
        builder: (context, basketState) {
          if (basketState.status.isClearedBasket || basketState.isCartChanged) {
            context.read<FavoriteCubit>().fetchFavorites();
          }
          return RefreshIndicator(
            onRefresh: (){
              context.read<FavoriteCubit>().fetchFavorites();
              return Future.value();
            },
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    if (state.status.isSuccess &&
                        state.entity?.isNotEmpty == true) {
                      return GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 12, bottom: 24),
                        itemCount: state.entity?.length,
                        itemBuilder: (context, index) {
                          ProductHiveModel? itemInBasket =
                              basketState.allProducts?.firstWhere(
                            (element) => element.id == state.entity?[index].id,
                            orElse: () => ProductHiveModel(
                              id: -1,
                              name: {},
                              description: {},
                              price: 0,
                            ),
                          );
                          return BlocProvider(
                            create: (context) => BasketButtonBloc(itemInBasket),
                            child: ProductWidget(product: state.entity![index]),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          mainAxisExtent: 350,
                        ),
                      );
                    } else if (state.status.isSuccess &&
                        state.entity?.isEmpty == true) {
                      return buildEmptyFavorite(context);
                    } else if (state.status.isLoading) {
                      return const ProductLoadingWidget();
                    } else {
                      return buildEmptyFavorite(context);
                    }
                  },
                )),
          );
        },
      ),
    );
  }

  Column buildEmptyFavorite(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.0),
          child: Image.asset(AppAssets.favoriteEmpty),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 12),
          child: Text(
            S.of(context).favoriteEmpty,
            style:
                AppTextStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          S.of(context).hereWillFavorite,
          style: AppTextStyle.bodyLarge.copyWith(color: AppColors.textGray),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
