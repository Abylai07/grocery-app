import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/domain/entity/product/category_entity.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:abricoz_app/src/presentation/view/category/widgets/sub_category_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../domain/entity/product/sub_category_entity.dart';
import '../../../get_it_sl.dart';
import '../../widgets/empty_answer_widget.dart';
import '../../widgets/main_functions.dart';
import '../../widgets/search_app_bar.dart';
import '../basket/bloc/basket_bloc/basket_bloc.dart';
import '../product/bloc/search_bloc/search_product_cubit.dart';
import '../product/screens/search_product_view.dart';
import 'bloc/sub_category_cubit.dart';
import 'widgets/category_widget.dart';

@RoutePage()
class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});
  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SubCategoryCubit(sl())..fetchSubCategory(category.id),
        ),
        BlocProvider(
          create: (context) => SearchProductCubit(sl()),
        )
      ],
      child: SubCategoryView(
        category: category,
      ),
    );
  }
}

class SubCategoryView extends StatelessWidget {
  const SubCategoryView({super.key, required this.category});
  final CategoryEntity category;
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return PopScope(
      canPop: true,
      onPopInvoked: (canPop){
        context.read<BasketBloc>().add(const RefreshBasket());
      },
      child: Scaffold(
        appBar: SearchAppBar(
          onBackPressed: () {
            context.router.maybePop();
            context.read<BasketBloc>().add(const RefreshBasket());
          },
          controller: searchController,
          onSent: (value) {
            context
                .read<SearchProductCubit>()
                .searchItems(value ?? '');
          },
          onChanged: (val) {
            if (val != null && val.length >= 2) {
              context
                  .read<SearchProductCubit>()
                  .fetchSearchHint(val);
            }
          },
        ),
        body: ValueListenableBuilder(
            valueListenable: searchController,
            builder: (context, TextEditingValue value, _) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: value.text.length >= 2
                    ? const CustomScrollView(
                        slivers: [
                          SearchProductsView(),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getLocaleText(category.name),
                              style: AppTextStyle.titleBold,
                            ),
                            BlocBuilder<SubCategoryCubit, BaseState>(
                              builder: (context, state) {
                                if (state.status.isSuccess) {
                                  List<SubCategoryEntity> subCategories =
                                      state.entity;
                                  return subCategories.isNotEmpty ? GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 24),
                                    itemCount: subCategories.length,
                                    itemBuilder: (context, index) {
                                      return SubCategoryWidget(
                                        subCategory: subCategories[index],
                                      );
                                    },
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          3, // number of items in each row
                                      mainAxisSpacing:
                                          8.0, // spacing between rows
                                      crossAxisSpacing:
                                          8.0, // spacing between columns
                                      mainAxisExtent: 124,
                                    ),
                                  ) : EmptyAnswerWidget(
                                    description: S.of(context).otherCategory,
                                  );
                                } else if (state.status.isLoading) {
                                  return const CategoryLoadingWidget();
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
              );
            }),
      ),
    );
  }
}
