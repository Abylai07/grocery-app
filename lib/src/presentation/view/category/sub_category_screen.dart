import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/domain/entity/product/category_entity.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:abricoz_app/src/presentation/view/category/widgets/sub_category_widget.dart';
import 'package:abricoz_app/src/presentation/view/product/bloc/product_cubit.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/product/sub_category_entity.dart';
import '../../../get_it_sl.dart';
import '../../widgets/main_functions.dart';
import '../../widgets/search_app_bar.dart';
import '../home/widgets/search_product_view.dart';
import '../product/bloc/search_bloc/search_product_cubit.dart';
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
          create: (_) => SubCategoryCubit(sl())..fetchSubCategory(),
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
    return Scaffold(
      appBar: SearchAppBar(
        controller: searchController,
        onChanged: (val) {
          context.read<SearchProductCubit>().searchItems(val ?? '');
        },
      ),
      body: ValueListenableBuilder(
          valueListenable: searchController,
          builder: (context, TextEditingValue value, _) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                FocusScope.of(context).unfocus();
                return false;
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: value.text.isNotEmpty
                    ? const CustomScrollView(
                        slivers: [
                          SearchProductView(),
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
                                  return GridView.builder(
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
              ),
            );
          }),
    );
  }
}
