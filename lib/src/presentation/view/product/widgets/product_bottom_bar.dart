import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/product/product_entity.dart';
import '../../../widgets/main_functions.dart';
import '../../basket/bloc/basket_button_bloc/basket_button_bloc.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({super.key, required this.product});

  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    bool isDiscount = isDiscountFunc(product.priceWithDiscount, product.price);
    bool isActive = (product.amount ?? 0) > 0;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      )),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                if (isDiscount)
                  Text(
                    '${product.priceWithDiscount} ₸  ',
                    style: AppTextStyle.titleMedium
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                Text(
                  '${product.price.toInt()} ₸',
                  style: isDiscount
                      ? AppTextStyle.titleSmall.copyWith(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.gray,
                          color: AppColors.gray)
                      : AppTextStyle.titleMedium
                          .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            BlocBuilder<BasketButtonBloc, BasketButtonState>(
              builder: (context, state) {
                return state.inBasket && isActive
                    ? Container(
                        height: 48,
                        width: 140,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
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
                            },
                            child: Container(
                              height: 48,
                              width: 140,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.main,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                S.of(context).toBasket,
                                style: AppTextStyle.bodyMedium
                                    .copyWith(color: AppColors.white),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              context
                                  .read<BasketButtonBloc>()
                                  .add(AddToBasket(product));
                            },
                            child: Container(
                              height: 48,
                              width: 140,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.notActiveColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                S.of(context).notActive,
                                style: AppTextStyle.bodyMedium
                                    .copyWith(color: AppColors.white),
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
