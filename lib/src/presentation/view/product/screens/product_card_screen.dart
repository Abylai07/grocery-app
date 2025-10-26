import 'package:grocery_app/src/presentation/view/product/widgets/product_bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../common/utils/shared_preference.dart';
import '../../../../domain/entity/product/product_entity.dart';
import '../../../widgets/main_functions.dart';
import '../../../widgets/modal_bottoms/non_authorize_modal.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../favorite/bloc/favorite_bloc/favorite_cubit.dart';
import '../widgets/product_structure_widget.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    double photoHeight = MediaQuery.of(context).size.height * 0.4;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0.8,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.background,
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    bool isFavorite = state.entity
                            ?.any((element) => element.id == product.id) ??
                        false;
                    return IconButton(
                      onPressed: () {
                        if (SharedPrefs().getAccessToken() == null) {
                          nonAuthorizeModal(context);
                        } else {
                          context
                              .read<FavoriteCubit>()
                              .storeOrDeleteFavorite(isFavorite, product);
                        }
                      },
                      icon: SvgPicture.asset(isFavorite
                          ? AppAssets.favoriteFill
                          : AppAssets.favorite),
                    );
                  },
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(AppAssets.close),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: ProductBottomBar(product: product),
            body: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: product.photoUrl?.isNotEmpty == true
                                  ? CachedNetworkImage(
                                      height: photoHeight,
                                      width: double.infinity,
                                      imageUrl: product.photoUrl!,
                                      fit: BoxFit.contain,
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
                            ),
                            Visibility(
                              visible: (product.amount ?? 0) < 1,
                              child: Container(
                                color: AppColors.gray,
                                width: double.infinity,
                                child: Text(
                                  S.of(context).out_stock,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bodyLarge.copyWith(
                                    color: const Color(0xFF606060),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
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
                        // const Divider(
                        //   height: 24,
                        //   color: AppColors.gray,
                        // ),
                        // Text(
                        //   S.of(context).brand,
                        //   style: AppTextStyle.bodyLarge
                        //       .copyWith(fontWeight: FontWeight.w600),
                        // ),
                        // Text(
                        //   product.brand?.name ?? '',
                        //   style: AppTextStyle.bodyMedium.copyWith(
                        //     fontWeight: FontWeight.w400,
                        //     color: AppColors.textGray,
                        //   ),
                        // ),
                        // const Divider(
                        //   height: 24,
                        //   color: AppColors.gray,
                        // ),
                        // Text(
                        //   S.of(context).maker,
                        //   style: AppTextStyle.bodyLarge
                        //       .copyWith(fontWeight: FontWeight.w600),
                        // ),
                        // Text(
                        //   product.country?.name ?? '',
                        //   style: AppTextStyle.bodyMedium.copyWith(
                        //     fontWeight: FontWeight.w400,
                        //     color: AppColors.textGray,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
