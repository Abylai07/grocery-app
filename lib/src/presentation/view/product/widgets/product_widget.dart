import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/domain/entity/product/product_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../widgets/main_functions.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../basket/basket_bloc/basket_bloc.dart';
import '../product_card_screen.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product});

  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    bool isDiscount = product.discount != null && product.discount! > 0;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: AppColors.white,
          constraints: BoxConstraints(
            maxHeight: 0.9.sh,
          ),
          builder: (cxt) {
            return BlocProvider.value(
              value: BlocProvider.of<BasketBloc>(context),
              child: ProductCardScreen(
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
                      product.photoUrl?.isNotEmpty == true
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
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(AppAssets.favorite),
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    getLocaleText(product.description),
                    maxLines: 2,
                    style: AppTextStyle.labelMedium
                        .copyWith(color: AppColors.gray),
                  ),
                ),
              ],
            ),
            BlocBuilder<BasketBloc, BasketState>(
              builder: (context, state) {
                return state.inBasket
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
                                      .read<BasketBloc>()
                                      .add(DecrementCount(product));
                                } else if (state.count == 1) {
                                  context
                                      .read<BasketBloc>()
                                      .add(DeleteAtBasket(product));
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
                                    .read<BasketBloc>()
                                    .add(IncrementCount(product));
                              },
                            ),
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          context.read<BasketBloc>().add(AddToBasket(product));
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
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
