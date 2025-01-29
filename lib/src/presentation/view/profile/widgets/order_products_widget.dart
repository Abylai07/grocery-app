import 'package:abricoz_app/src/common/enums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/order/order_history_entity.dart';
import '../../../../domain/entity/product/product_entity.dart';
import '../../../widgets/main_functions.dart';
import '../../../widgets/shimmer_widget.dart';

class OrderProductsWidget extends StatelessWidget {
  const OrderProductsWidget({
    super.key,
    required this.orderInfo,
  });

  final OrderHistoryEntity? orderInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${S.of(context).itemList} (${orderInfo?.products.length})',
            style: AppTextStyle.titleBold,
          ),
          ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: orderInfo?.products.length ?? 0,
            itemBuilder: (context, index) {
              ProductEntity product = orderInfo!.products[index];
              bool isDiscount =
              isDiscountFunc(product.priceWithDiscount, product.price);

              return Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundGray,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: product.photoUrl != null
                        ? CachedNetworkImage(
                      imageUrl: product.photoUrl!,
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                      const ShimmerWidget(
                        width: 70,
                        height: 70,
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    )
                        : const SizedBox(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getLocaleText(product.name),
                            maxLines: 2,
                            style: AppTextStyle.labelMedium,
                          ),
                          4.height,
                          Row(
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
                          )
                        ],
                      ),
                    ),
                  ),
                  if(product.pivot?.productQuantity != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${product.pivot?.productQuantity} ${S.of(context).pcs}',
                        style: AppTextStyle.labelMedium,
                      ),
                    )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 8);
            },
          )
        ],
      ),
    );
  }
}