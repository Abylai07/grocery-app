import 'package:abricoz_app/src/presentation/view/product/widgets/product_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../data/hive/adapter/product_adapter.dart';
import '../../../../data/hive/hive_database.dart';
import '../../../../domain/entity/product/product_entity.dart';
import '../../basket/basket_bloc/basket_bloc.dart';
import '../../product/bloc/search_bloc/search_product_cubit.dart';
import '../../product/widgets/product_widget.dart';

class SearchProductView extends StatelessWidget {
  const SearchProductView({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductHiveModel> basketList = BasketDatabase().getAllProducts();
    double bottom = MediaQuery.of(context).viewInsets.bottom;

    return BlocBuilder<SearchProductCubit, SearchProductState>(
      builder: (context, state) {
        final cubit = context.read<SearchProductCubit>();
        return PagedSliverGrid<int, ProductEntity>(
          pagingController: cubit.pagingController,
          showNewPageProgressIndicatorAsGridChild: false,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    padding: const EdgeInsets.symmetric(horizontal: 56.0),
                    child: Image.asset(AppAssets.searchEmpty),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 12),
                    child: Text(
                      S.of(context).notFound,
                      style: AppTextStyle.titleMedium
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: bottom),
                    child: Text(
                      S.of(context).againOtherWord,
                      style: AppTextStyle.bodyLarge
                          .copyWith(color: AppColors.textGray),
                      textAlign: TextAlign.center,
                    ),
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
        );
      },
    );
  }
}
