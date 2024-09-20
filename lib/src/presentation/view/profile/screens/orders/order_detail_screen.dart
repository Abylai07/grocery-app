import 'package:abricoz_app/src/common/enums.dart';
import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../domain/entity/order/order_history_entity.dart';
import '../../../../../domain/entity/product/product_entity.dart';
import '../../../../widgets/buttons/main_button.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/main_functions.dart';
import '../../../../widgets/padding_nav_buttons.dart';
import '../../../../widgets/shimmer_widget.dart';

@RoutePage()
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderInfo});
  final OrderHistoryEntity orderInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '${S.of(context).order} №${orderInfo.id}',
      ),
      backgroundColor: AppColors.background,
      bottomNavigationBar: PaddingForNavButtons(
        child: CustomMainButton(
          text: S.of(context).orderAgain,
          isActive: false,
          onTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildOrderInfo(context),
            12.height,
            buildOrderProducts(context),
          ],
        ),
      ),
    );
  }

  Container buildOrderProducts(BuildContext context) {
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
            S.of(context).itemList,
            style: AppTextStyle.titleBold,
          ),
          ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: orderInfo.products.length,
            itemBuilder: (context, index) {
              ProductEntity product = orderInfo.products[index];
              bool isDiscount = product.priceWithDiscount != null &&
                  product.priceWithDiscount! > 0;
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

  Container buildOrderInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).createDate,
              style:
              AppTextStyle.labelMedium.copyWith(color: AppColors.textGray),
            ),
            Text(
              formatDate(orderInfo.createdAt),
              style: AppTextStyle.bodyMedium,
            ),
            const Divider(
              height: 32,
              color: AppColors.divider,
            ),
            Text(
              S.of(context).deliveryDate,
              style:
              AppTextStyle.labelMedium.copyWith(color: AppColors.textGray),
            ),
            Text(
              '${formatDate(orderInfo.deliveryDate)}, ${orderInfo.deliveryInterval.name}',
              style: AppTextStyle.bodyMedium,
            ),
            const Divider(
              height: 32,
              color: AppColors.divider,
            ),
            Text(
              S.of(context).deliveryAddress,
              style:
              AppTextStyle.labelMedium.copyWith(color: AppColors.textGray),
            ),
            Text(
              '${orderInfo.addressStreetAndHouse}, ${orderInfo.addressApartment}',
              style: AppTextStyle.bodyMedium,
            ),
            const Divider(
              height: 32,
              color: AppColors.divider,
            ),
            Text(
              S.of(context).status,
              style:
              AppTextStyle.labelMedium.copyWith(color: AppColors.textGray),
            ),
            Text(
              orderInfo.orderStatus.name,
              style: AppTextStyle.bodyMedium,
            ),
            const Divider(
              height: 32,
              color: AppColors.divider,
            ),
            Text(
              S.of(context).totalSum,
              style:
              AppTextStyle.labelMedium.copyWith(color: AppColors.textGray),
            ),
            Text(
              '${orderInfo.totalPrice.toInt()} ₸',
              style: AppTextStyle.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
