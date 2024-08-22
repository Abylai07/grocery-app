import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/domain/entity/product/product_entity.dart';
import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../data/hive/adapter/product_adapter.dart';
import '../../../../data/hive/hive_database.dart';
import '../../../../domain/entity/product/search_hint_entity.dart';
import '../../../../get_it_sl.dart';
import '../../../bloc/base_state.dart';
import '../../../widgets/main_functions.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../basket/bloc/basket_button_bloc/basket_button_bloc.dart';
import '../bloc/product_info_cubit.dart';
import '../widgets/product_bottom_bar.dart';
import '../widgets/product_structure_widget.dart';

@RoutePage()
class SearchedProductScreen extends StatelessWidget {
  const SearchedProductScreen({super.key, required this.searchHint});
  final SearchHintEntity searchHint;

  @override
  Widget build(BuildContext context) {
    ProductHiveModel itemInBasket =
        BasketDatabase().getProductById(searchHint.id.toString());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BasketButtonBloc(itemInBasket),
        ),
        BlocProvider(
          create: (context) =>
              ProductInfoCubit(sl())..fetchProductInfo(searchHint.id),
        ),
      ],
      child: const SearchedProductView(),
    );
  }
}

class SearchedProductView extends StatelessWidget {
  const SearchedProductView({super.key});

  @override
  Widget build(BuildContext context) {
    double photoHeight = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppAssets.back),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                //Navigator.pop(context);
              },
              icon: SvgPicture.asset(AppAssets.favorite),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<ProductInfoCubit, BaseState>(
        builder: (context, state) {
          if (state.status.isSuccess) {
            return ProductBottomBar(product: state.entity);
          } else {
            return const SizedBox();
          }
        },
      ),
      body: BlocBuilder<ProductInfoCubit, BaseState>(
        builder: (context, state) {
          if (state.status.isSuccess) {
            ProductEntity product = state.entity;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        product.photoUrl?.isNotEmpty == true
                            ? CachedNetworkImage(
                                height: photoHeight,
                                width: double.infinity,
                                imageUrl: product.photoUrl!,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        ShimmerWidget(
                                  width: double.infinity,
                                  height: photoHeight,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : Container(
                                width: double.infinity,
                                height: photoHeight,
                                color: AppColors.shimmer,
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: RichText(
                            text: TextSpan(
                              text: getLocaleText(product.name),
                              style: AppTextStyle.titleMedium
                                  .copyWith(fontWeight: FontWeight.w700),
                              children: [
                                TextSpan(
                                  text: '  ${product.weight}',
                                  style: AppTextStyle.titleMedium.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.gray),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ProductStructureWidget(
                    product: product,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).description,
                          style: AppTextStyle.titleSmall
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          getLocaleText(product.description),
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.textGray,
                          ),
                        ),
                        const Divider(
                          height: 24,
                          color: AppColors.gray,
                        ),
                        Text(
                          S.of(context).brand,
                          style: AppTextStyle.bodyLarge
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          product.brand?.name ?? '',
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.textGray,
                          ),
                        ),
                        const Divider(
                          height: 24,
                          color: AppColors.gray,
                        ),
                        Text(
                          S.of(context).maker,
                          style: AppTextStyle.bodyLarge
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          product.country?.name ?? '',
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.textGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
