import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/domain/entity/order/order_entity.dart';
import 'package:abricoz_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../widgets/main_functions.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../profile/bloc/order_history_cubit.dart';

@RoutePage()
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.orderInfo});
  final OrderEntity orderInfo;

  @override
  Widget build(BuildContext context) {
    context.read<OrderHistoryCubit>().fetchOrderHistory();
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).paymentOrder,
      ),
      backgroundColor: AppColors.background,
      // bottomNavigationBar: PaddingForNavButtons(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       CustomMainButton(
      //         text: S.of(context).paymentOrder,
      //         onTap: () {},
      //       ),
      //       12.height,
      //       CustomGrayButton(
      //         text: S.of(context).cancelOrder,
      //         onTap: () {},
      //       ),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildOrderInfo(context),
            // No Online Payment
            // Container(
            //   margin: const EdgeInsets.symmetric(vertical: 12),
            //   padding: const EdgeInsets.all(16.0),
            //   decoration: BoxDecoration(
            //     color: AppColors.white,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Row(
            //     children: [
            //       SvgPicture.asset(AppAssets.time),
            //       12.width,
            //       Expanded(child: Text(S.of(context).payTime(223))),
            //     ],
            //   ),
            // ),
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
            itemCount: orderInfo.orderProducts.length,
            itemBuilder: (context, index) {
              OrderProductEntity product = orderInfo.orderProducts[index];
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
              S.of(context).orderNumber,
              style:
                  AppTextStyle.labelMedium.copyWith(color: AppColors.textGray),
            ),
            Text(
              '№ ${orderInfo.orderId}',
              style: AppTextStyle.bodyMedium,
            ),
            const Divider(
              height: 32,
              color: AppColors.divider,
            ),
            Text(
              S.of(context).paymentType,
              style:
                  AppTextStyle.labelMedium.copyWith(color: AppColors.textGray),
            ),
            Text(
              orderInfo.paymentType,
              style: AppTextStyle.bodyMedium,
            ),
            const Divider(
              height: 32,
              color: AppColors.divider,
            ),
            Text(
              S.of(context).payOrder,
              style:
                  AppTextStyle.labelMedium.copyWith(color: AppColors.textGray),
            ),
            Text(
              '${orderInfo.totalPrice} ₸',
              style: AppTextStyle.bodyMedium,
            ),
            const Divider(
              height: 32,
              color: AppColors.divider,
            ),
            Text(
              S.of(context).paymentStatus,
              style:
                  AppTextStyle.labelMedium.copyWith(color: AppColors.textGray),
            ),
            Text(
              orderInfo.orderStatus,
              style: AppTextStyle.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
