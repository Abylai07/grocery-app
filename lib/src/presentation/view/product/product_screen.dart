import 'package:abricoz_app/src/data/hive/hive_database.dart';
import 'package:abricoz_app/src/domain/entity/product/product_entity.dart';
import 'package:abricoz_app/src/domain/entity/product/sub_category_entity.dart';
import 'package:abricoz_app/src/presentation/view/product/bloc/product_cubit.dart';
import 'package:abricoz_app/src/presentation/view/product/widgets/product_loading_widget.dart';
import 'package:abricoz_app/src/presentation/view/product/widgets/product_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../common/app_styles/assets.dart';
import '../../../common/app_styles/colors.dart';
import '../../../common/app_styles/text_styles.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../data/hive/adapter/product_adapter.dart';
import '../../../get_it_sl.dart';
import '../../bloc/base_state.dart';
import '../../widgets/main_functions.dart';
import '../basket/basket_bloc/basket_bloc.dart';

@RoutePage()
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.subCategory});
  final SubCategoryEntity subCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(sl())..setCategoryId(subCategory.id),
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(AppAssets.back),
          onPressed: () {
            context.router.maybePop();
          },
        ),
        centerTitle: true,
        title: Text(getLocaleText(subCategory.name)),
      ),
      body: BlocBuilder<ProductsCubit, BaseState>(
        builder: (context, state) {
          final cubit = context.read<ProductsCubit>();
          return RefreshIndicator(
            onRefresh: () => Future.sync(
              () {
                context.read<ProductsCubit>().pagingController.refresh();
              },
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
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
                      mainAxisExtent: 360,
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
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 56.0),
                              child: Image.asset(AppAssets.searchEmpty),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 18.0, bottom: 12),
                              child: Text(
                                S.of(context).notFound,
                                style: AppTextStyle.titleMedium
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              S.of(context).againOtherWord,
                              style: AppTextStyle.bodyLarge
                                  .copyWith(color: AppColors.textGray),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
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
                          create: (context) => BasketBloc(itemInBasket),
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
      ),
    );
  }
}
