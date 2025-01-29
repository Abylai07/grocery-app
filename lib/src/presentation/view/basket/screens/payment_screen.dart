import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/domain/entity/order/order_entity.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:abricoz_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/order/order_history_entity.dart';
import '../../../../domain/entity/product/product_entity.dart';
import '../../../../get_it_sl.dart';
import '../../../widgets/alert_dialog/text_alert_dialog.dart';
import '../../../widgets/buttons/main_button.dart';
import '../../../widgets/main_functions.dart';
import '../../../widgets/padding_nav_buttons.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../profile/bloc/order/active_orders_cubit.dart';
import '../../profile/bloc/order/order_history_cubit.dart';
import '../../profile/widgets/order_products_widget.dart';
import '../bloc/order_bloc/order_cubit.dart';

@RoutePage()
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.orderInfo});
  final OrderEntity orderInfo;

  @override
  Widget build(BuildContext context) {
    context.read<ActiveOrdersCubit>().fetchActiveOrders();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderCubit(sl()),
        ),
        BlocProvider(
          create: (context) =>
              OrderHistoryCubit(sl())..fetchOrderById(orderInfo.orderId),
        ),
      ],
      child: BlocBuilder<OrderHistoryCubit, BaseState>(
        builder: (context, state) {
          OrderHistoryEntity? order;
          if (state.status.isSuccess) {
            order = state.entity;
          }

          return Scaffold(
            appBar: CustomAppBar(
              title: S.of(context).order_info,
            ),
            backgroundColor: AppColors.background,
            bottomNavigationBar: order != null
                ? PaddingForNavButtons(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocConsumer<OrderCubit, OrderState>(
                          listener: (context, state) {
                            if (state.status.isSuccess) {
                              Navigator.pop(context);
                              context
                                  .read<ActiveOrdersCubit>()
                                  .fetchActiveOrders();
                            }
                          },
                          builder: (context, state) {
                            return CustomMainButton(
                              text: canCancelOrder(order!)
                                  ? S.of(context).cancelOrder
                                  : S.of(context).orderAgain,
                              isLoading: state.status.isLoading,
                              isActive: order.orderStatus.id == 1,
                              onTap: () {
                                if (canCancelOrder(order!)) {
                                  confirmAlertDialog(
                                    context,
                                    title:
                                        S.of(context).cancel_order_confirmation,
                                    onYesTap: () {
                                      Navigator.pop(context);
                                      context.read<OrderCubit>().cancelOrder(
                                          orderId: order!.id.toString());
                                    },
                                  );
                                }
                              },
                            );
                          },
                        ),
                        // 12.height,
                        // CustomGrayButton(
                        //   text: S.of(context).cancelOrder,
                        //   onTap: () {},
                        // ),
                      ],
                    ),
                  )
                : const SizedBox(),
            body: state.status.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await context
                          .read<OrderHistoryCubit>()
                          .fetchOrderById(orderInfo.orderId);
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          buildOrderInfo(context, order),
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
                          OrderProductsWidget(orderInfo: order),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Container buildOrderInfo(BuildContext context, OrderHistoryEntity? order) {
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
              S.of(context).totalSum,
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
              S.of(context).order_status,
              style:
                  AppTextStyle.labelMedium.copyWith(color: AppColors.textGray),
            ),
            Text(
              order?.orderStatus.name ?? orderInfo.orderStatus,
              style: AppTextStyle.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
