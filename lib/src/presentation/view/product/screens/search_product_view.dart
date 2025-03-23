import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/presentation/view/product/widgets/product_loading_widget.dart';
import 'package:abricoz_app/src/presentation/widgets/main_functions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../data/hive/adapter/product_adapter.dart';
import '../../../../data/hive/hive_database.dart';
import '../../../../domain/entity/product/product_entity.dart';
import '../../../widgets/empty_answer_widget.dart';
import '../../basket/bloc/basket_bloc/basket_bloc.dart';
import '../../basket/bloc/basket_button_bloc/basket_button_bloc.dart';
import '../bloc/search_bloc/search_product_cubit.dart';
import '../widgets/product_widget.dart';

class SearchProductsView extends StatelessWidget {
  const SearchProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductHiveModel> basketList = BasketDatabase().getAllProducts();

    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        basketList = state.allProducts ?? BasketDatabase().getAllProducts();
        return BlocBuilder<SearchProductCubit, SearchProductState>(
          builder: (context, state) {
            if (state.status.isSuccessHint) {
              return state.searchHints?.isNotEmpty == true
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => InkWell(
                          onTap: () {
                            if (state.searchHints != null) {
                              context.router.push(SearchedProductRoute(
                                  searchHint: state.searchHints![index]));
                            }
                          },
                          child: ListTile(
                            leading: SvgPicture.asset(AppAssets.search),
                            title: Text(
                              getLocaleText(state.searchHints?[index].name),
                              style: AppTextStyle.bodyLarge,
                            ),
                            trailing: SvgPicture.asset(AppAssets.arrowNext),
                          ),
                        ),
                        childCount: state.searchHints?.length,
                      ),
                    )
                  : const SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          EmptyAnswerWidget(),
                        ],
                      ),
                    );
            } else if (state.status.isSearchSubmit || state.status.isSuccess) {
              final cubit = context.read<SearchProductCubit>();
              return PagedSliverGrid<int, ProductEntity>(
                pagingController: cubit.pagingController,
                showNewPageProgressIndicatorAsGridChild: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  mainAxisExtent: 350,
                ),
                builderDelegate: PagedChildBuilderDelegate<ProductEntity>(
                  firstPageProgressIndicatorBuilder: (context) {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductLoadingWidget(),
                      ],
                    );
                  },
                  noItemsFoundIndicatorBuilder: (context) {
                    return const EmptyAnswerWidget();
                  },
                  itemBuilder: (context, item, index) {
                    ProductHiveModel itemInBasket = basketList.firstWhere(
                      (element) => element.id == item.id,
                      orElse: () => ProductHiveModel(
                        id: -1,
                        subcategoryId: -1,
                        name: {},
                        description: {},
                        price: 0,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                    );
                    return BlocProvider(
                      key: ValueKey('${itemInBasket.id}=${itemInBasket.basketCount}'),
                      create: (context) => BasketButtonBloc(itemInBasket),
                      child: ProductWidget(product: item),
                    );
                  },
                ),
              );
            } else if (state.status.isLoading) {
              return SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator.adaptive(),
                ),
              );
            } else {
              return const SliverToBoxAdapter();
            }
          },
        );
      },
    );
  }
}
