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
import '../../bloc/search_bloc/search_bloc.dart';
import '../../widgets/content_error_widget.dart';
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
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
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
      onPopInvoked: (canPop) {
        context.read<BasketBloc>().add(const RefreshBasket());
      },
      child: Scaffold(
        appBar: SearchAppBar(
          title: getLocaleText(category.name),
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
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: CustomScrollView(
                slivers: [
                  state.isShowWidgets
                      ? const SearchProductsView()
                      : SliverFillRemaining(
                          child: BlocBuilder<SubCategoryCubit, BaseState>(
                            builder: (context, state) {
                              if (state.status.isSuccess) {
                                List<SubCategoryEntity> subCategories =
                                    state.entity;
                                return subCategories.isNotEmpty
                                    ? GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
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
                                      )
                                    : EmptyAnswerWidget(
                                        description:
                                            S.of(context).otherCategory,
                                      );
                              } else if (state.status.isLoading) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CategoryLoadingWidget(),
                                  ],
                                );
                              } else if (state.status.isError){
                                return ContentErrorWidget(
                                  message: S.of(context).error_message,
                                  onTryAgain: () {
                                    context.read<SubCategoryCubit>().fetchSubCategory(category.id);
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
