import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/data/hive/hive_database.dart';
import 'package:abricoz_app/src/domain/entity/product/product_entity.dart';
import 'package:abricoz_app/src/domain/entity/product/sub_category_entity.dart';
import 'package:abricoz_app/src/presentation/view/product/bloc/product_cubit.dart';
import 'package:abricoz_app/src/presentation/view/product/screens/search_product_view.dart';
import 'package:abricoz_app/src/presentation/view/product/widgets/product_loading_widget.dart';
import 'package:abricoz_app/src/presentation/view/product/widgets/product_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../data/hive/adapter/product_adapter.dart';
import '../../../get_it_sl.dart';
import '../../bloc/base_state.dart';
import '../../bloc/search_bloc/search_bloc.dart';
import '../../widgets/empty_answer_widget.dart';
import '../../widgets/main_functions.dart';
import '../../widgets/search_app_bar.dart';
import '../basket/bloc/basket_bloc/basket_bloc.dart';
import '../basket/bloc/basket_button_bloc/basket_button_bloc.dart';
import 'bloc/search_bloc/search_product_cubit.dart';

@RoutePage()
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.subCategory});
  final SubCategoryEntity subCategory;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductsCubit(sl())..setCategoryId(subCategory.id),
        ),
        BlocProvider(
          create: (context) => SearchProductCubit(sl()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: ProductView(
        subCategory: subCategory,
      ),
    );
  }
}

class ProductView extends StatelessWidget {
  const ProductView({super.key, required this.subCategory});
  final SubCategoryEntity subCategory;

  @override
  Widget build(BuildContext context) {
    List<ProductHiveModel> basketList = BasketDatabase().getAllProducts();
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: SearchAppBar(
        title: getLocaleText(subCategory.name),
        controller: searchController,
        onSent: (value) {
          context.read<SearchProductCubit>().searchItems(value ?? '');
        },
        onChanged: (val) {
          if (val != null && val.length >= 2) {
            context.read<SearchProductCubit>().fetchSearchHint(val);
          }
          final searchBloc = context.read<SearchBloc>();
          if (searchBloc.state.isShowWidgets && (val?.length ?? 0) < 2) {
            searchBloc.add(ToggleWidgetsVisibility());
          }
          if (!searchBloc.state.isShowWidgets && (val?.length ?? 0) > 2) {
            searchBloc.add(ToggleWidgetsVisibility());
          }
        },
      ),
      body: BlocListener<BasketBloc, BasketState>(
        listener: (context, state) {
          if (state.status.isClearedBasket) {
            context.read<ProductsCubit>().pagingController.refresh();
          }
        },
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state.isShowWidgets) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: CustomScrollView(
                  slivers: [
                    SearchProductsView(),
                  ],
                ),
              );
            }
            return BlocBuilder<ProductsCubit, BaseState>(
              builder: (context, state) {
                final cubit = context.read<ProductsCubit>();
                if (state.status.isSuccess) {
                  basketList = BasketDatabase().getAllProducts();
                }
                return RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () {
                      context.read<ProductsCubit>().pagingController.refresh();
                      basketList = BasketDatabase().getAllProducts();
                    },
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: CustomScrollView(
                      slivers: [
                        PagedSliverGrid<int, ProductEntity>(
                          pagingController: cubit.pagingController,
                          showNewPageProgressIndicatorAsGridChild: false,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            mainAxisExtent: 334,
                          ),
                          builderDelegate:
                              PagedChildBuilderDelegate<ProductEntity>(
                            firstPageProgressIndicatorBuilder: (context) {
                              return const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProductLoadingWidget(),
                                ],
                              );
                            },
                            noItemsFoundIndicatorBuilder: (context) {
                              return EmptyAnswerWidget(
                                description: S.of(context).otherCategory,
                              );
                            },
                            itemBuilder: (context, item, index) {
                              ProductHiveModel itemInBasket =
                                  basketList.firstWhere(
                                (element) => element.id == item.id,
                                orElse: () => ProductHiveModel(
                                  id: -1,
                                  name: {},
                                  description: {},
                                  price: 0,
                                ),
                              );

                              return BlocProvider(
                                create: (context) =>
                                    BasketButtonBloc(itemInBasket),
                                child: ProductWidget(product: item),
                              );
                            },
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 40),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
