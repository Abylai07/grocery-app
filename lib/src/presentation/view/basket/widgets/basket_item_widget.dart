import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/presentation/widgets/show_error_snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../data/hive/adapter/product_adapter.dart';
import '../../../../domain/entity/order/check_card_entity.dart';
import '../../../widgets/main_functions.dart';
import '../../../widgets/shimmer_widget.dart';
import '../bloc/basket_bloc/basket_bloc.dart';
import '../bloc/basket_button_bloc/basket_button_bloc.dart';

class BasketItemWidget extends StatelessWidget {
  const BasketItemWidget({
    super.key,
    required this.product,
  });

  final ProductHiveModel product;

  @override
  Widget build(BuildContext context) {
    bool isDiscount = isDiscountFunc(product.priceWithDiscount, product.price);

    return Row(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: AppColors.gray,
            borderRadius: BorderRadius.circular(10),
          ),
          child: product.photoUrl != null
              ? CachedNetworkImage(
                  imageUrl: product.photoUrl!,
                  fit: BoxFit.cover,
                  height: 70,
                  width: 70,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const ShimmerWidget(
                    width: 70,
                    height: 70,
                  ),
                  errorWidget: (context, url, error) => const SizedBox(),
                )
              : const SizedBox(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getLocaleText(product.name),
                  maxLines: 2,
                  style: AppTextStyle.labelMedium,
                ),
                4.height,
                (product.isActive == false)
                    ? Row(
                        children: [
                          Text(
                            '0 ₸ ',
                            style: AppTextStyle.labelMedium.copyWith(
                              color: const Color(0XFF7B7B7B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '∙ ${S.of(context).notActive}',
                            style: AppTextStyle.labelMedium.copyWith(
                              color: AppColors.gray,
                            ),
                          ),
                        ],
                      )
                    : (product.basketCount < 1)
                        ? Text(
                            S.of(context).out_of_stock,
                            style: AppTextStyle.labelMedium.copyWith(
                              color: AppColors.gray,
                            ),
                          )
                        : Row(
                            children: [
                              if (isDiscount)
                                Text(
                                  '${product.priceWithDiscount} ₸  ',
                                  style: AppTextStyle.labelMedium.copyWith(
                                    color: AppColors.main,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              Text(
                                '${product.price.toInt()} ₸',
                                style: isDiscount
                                    ? AppTextStyle.labelMedium.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: AppColors.gray,
                                        color: AppColors.gray)
                                    : AppTextStyle.labelMedium,
                              ),
                              if (product.weight != null)
                                Text(
                                  ' ∙ ${product.weight}',
                                  style: AppTextStyle.labelMedium.copyWith(
                                    color: AppColors.gray,
                                  ),
                                ),
                            ],
                          ),
              ],
            ),
          ),
        ),
        BlocBuilder<BasketButtonBloc, BasketButtonState>(
          builder: (context, state) {
            return ((product.isActive ?? false) && (product.basketCount > 0))
                ? Container(
                    height: 40,
                    width: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: state.count <= 1
                              ? SvgPicture.asset(
                                  AppAssets.remove,
                                  height: 18,
                                )
                              : const Icon(Icons.remove),
                          onPressed: () {
                            if (state.count > 1) {
                              context
                                  .read<BasketButtonBloc>()
                                  .add(DecrementCount(product.id));
                            } else if (state.count <= 1) {
                              context
                                  .read<BasketButtonBloc>()
                                  .add(DeleteAtBasket(product.id));
                            }
                            context
                                .read<BasketBloc>()
                                .add(const RefreshBasket());
                          },
                        ),
                        Text(
                          '${state.count}',
                          style: AppTextStyle.bodyMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            if (state.count < (product.availableQuantity ?? 0)) {
                              // Increment if within range
                              context
                                  .read<BasketButtonBloc>()
                                  .add(IncrementCount(product.id));
                              context
                                  .read<BasketBloc>()
                                  .add(const RefreshBasket());
                            } else {
                              // Optionally, show a message when the limit is reached
                              showErrorSnackBar(context, S.of(context).insufficient_stock);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                : InkWell(
                    onTap: () {
                      context
                          .read<BasketButtonBloc>()
                          .add(DeleteAtBasket(product.id));
                      context.read<BasketBloc>().add(const RefreshBasket());
                    },
                    child: Container(
                      height: 36,
                      width: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        S.of(context).delete,
                        style: AppTextStyle.labelMedium,
                      ),
                    ),
                  );
          },
        )
      ],
    );
  }
}
