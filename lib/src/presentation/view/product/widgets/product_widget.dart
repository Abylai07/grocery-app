import 'package:grocery_app/src/common/app_styles/assets.dart';
import 'package:grocery_app/src/common/app_styles/text_styles.dart';
import 'package:grocery_app/src/domain/entity/product/product_entity.dart';
import 'package:grocery_app/src/presentation/view/basket/bloc/basket_bloc/basket_bloc.dart';
import 'package:grocery_app/src/presentation/view/favorite/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../common/utils/shared_preference.dart';
import '../../../widgets/main_functions.dart';
import '../../../widgets/modal_bottoms/non_authorize_modal.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../basket/bloc/basket_button_bloc/basket_button_bloc.dart';
import '../screens/product_card_screen.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product});

  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    bool isDiscount = isDiscountFunc(product.priceWithDiscount, product.price);
    bool isActive = (product.amount ?? 0) > 0;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          useRootNavigator: true,
          backgroundColor: AppColors.white,
          builder: (cxt) {
            return BlocProvider.value(
              value: BlocProvider.of<BasketButtonBloc>(context),
              child: ProductCardView(
                product: product,
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 177,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: product.photoUrl?.isNotEmpty == true
                                ? CachedNetworkImage(
                                    imageUrl: product.photoUrl!,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const ShimmerWidget(
                                      width: double.infinity,
                                      height: 177,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                : Image.asset(AppAssets.banner),
                          ),
                          Visibility(
                            visible: !isActive,
                            child: Container(
                              color: AppColors.gray,
                              width: double.infinity,
                              child: Text(
                                S.of(context).out_stock,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.labelSmall.copyWith(
                                  color: const Color(0xFF606060),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: BlocBuilder<FavoriteCubit, FavoriteState>(
                          builder: (context, state) {
                            bool isFavorite = state.entity?.any(
                                    (element) => element.id == product.id) ??
                                false;
                            return IconButton(
                              onPressed: () {
                                if (SharedPrefs().getAccessToken() == null) {
                                  nonAuthorizeModal(context);
                                } else {
                                  context
                                      .read<FavoriteCubit>()
                                      .storeOrDeleteFavorite(
                                          isFavorite, product);
                                }
                              },
                              icon: SvgPicture.asset(isFavorite
                                  ? AppAssets.favoriteFill
                                  : AppAssets.favorite),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 4),
                  child: Row(
                    children: [
                      if (isDiscount)
                        Text(
                          '${product.priceWithDiscount} ₸  ',
                          style: AppTextStyle.titleSmall
                              .copyWith(color: AppColors.main),
                        ),
                      Text(
                        '${product.price.toInt()} ₸',
                        style: isDiscount
                            ? AppTextStyle.labelLarge.copyWith(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: AppColors.gray,
                                color: AppColors.gray)
                            : AppTextStyle.titleSmall,
                      ),
                    ],
                  ),
                ),
                Text(
                  getLocaleText(product.name),
                  style: AppTextStyle.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 6.0),
                //   child: Text(
                //     getLocaleText(product.description),
                //     maxLines: 2,
                //     style: AppTextStyle.labelMedium
                //         .copyWith(color: AppColors.gray),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    product.weight ?? '',
                    style: AppTextStyle.labelMedium
                        .copyWith(color: AppColors.gray),
                  ),
                ),
              ],
            ),
            BlocBuilder<BasketButtonBloc, BasketButtonState>(
              builder: (context, state) {
                return state.inBasket && isActive
                    ? Container(
                        height: 40,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                if (state.count > 1) {
                                  context
                                      .read<BasketButtonBloc>()
                                      .add(DecrementCount(product.id));
                                } else if (state.count == 1) {
                                  context
                                      .read<BasketButtonBloc>()
                                      .add(DeleteAtBasket(product.id));
                                  context
                                      .read<BasketBloc>()
                                      .add(const RefreshBasket());
                                }
                              },
                            ),
                            Text(
                              '${state.count}',
                              style: AppTextStyle.bodyMedium,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                context
                                    .read<BasketButtonBloc>()
                                    .add(IncrementCount(product.id));
                              },
                            ),
                          ],
                        ),
                      )
                    : isActive
                        ? InkWell(
                            onTap: () {
                              context
                                  .read<BasketButtonBloc>()
                                  .add(AddToBasket(product));
                              context
                                  .read<BasketBloc>()
                                  .add(const RefreshBasket());
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                S.of(context).toBasket,
                                style: AppTextStyle.bodyMedium,
                              ),
                            ),
                          )
                        : Container(
                            height: 40,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.grayContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              S.of(context).notActive,
                              style: AppTextStyle.bodyMedium,
                            ),
                          );
              },
            )
          ],
        ),
      ),
    );
  }
}
