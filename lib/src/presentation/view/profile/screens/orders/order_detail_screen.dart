import 'package:grocery_app/src/common/enums.dart';
import 'package:grocery_app/src/presentation/view/basket/bloc/order_bloc/order_cubit.dart';
import 'package:grocery_app/src/presentation/view/profile/bloc/order/active_orders_cubit.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/app_router/app_router.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../domain/entity/order/order_history_entity.dart';
import '../../../../../get_it_sl.dart';
import '../../../../bloc/base_state.dart';
import '../../../../widgets/alert_dialog/text_alert_dialog.dart';
import '../../../../widgets/buttons/main_button.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/main_functions.dart';
import '../../../../widgets/padding_nav_buttons.dart';
import '../../../../widgets/show_error_snackbar.dart';
import '../../../basket/bloc/payment_bloc/payment_cubit.dart';
import '../../bloc/order/order_history_cubit.dart';
import '../../widgets/order_products_widget.dart';

@RoutePage()
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderCubit(sl()),
        ),
        BlocProvider(
          create: (context) => PaymentCubit(sl()),
        ),
        BlocProvider(
          create: (context) => OrderHistoryCubit(sl())..fetchOrderById(orderId),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          title: '${S.of(context).order} №$orderId',
        ),
        backgroundColor: AppColors.background,
        body: BlocBuilder<OrderHistoryCubit, BaseState>(
          builder: (context, state) {
            if (state.status.isSuccess) {
              OrderHistoryEntity order = state.entity;
              return Scaffold(
                backgroundColor: AppColors.background,
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton: BlocConsumer<OrderCubit, OrderState>(
                  listener: (context, state) {
                    if (state.status.isSuccess) {
                      Navigator.pop(context);
                      context.read<ActiveOrdersCubit>().fetchActiveOrders();
                    }
                  },
                  builder: (context, state) {
                    return PaddingForNavButtons(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (canPayOrder(order)) ...[
                            BlocConsumer<PaymentCubit, PaymentState>(
                              listener: (context, state) async {
                                if (state.status.isSuccess &&
                                    state.paymentUrl != null) {
                                  await AutoRouter.of(context).push(
                                    LinkPaymentRoute(
                                      url: state.paymentUrl!,
                                      type: 'halyk',
                                    ),
                                  );
                                  context
                                      .read<OrderHistoryCubit>()
                                      .fetchOrderById(orderId);
                                } else if (state.status.isError) {
                                  showErrorSnackBar(
                                    context,
                                    S.of(context).errorPlsAgain,
                                  );
                                }
                              },
                              builder: (context, state) {
                                return CustomMainButton(
                                  text: S.of(context).payOrder,
                                  isLoading: state.status.isLoading,
                                  isActive: canPayOrder(order),
                                  onTap: () {
                                    context
                                        .read<PaymentCubit>()
                                        .getPaymentLink(order.id);
                                  },
                                );
                              },
                            ),
                           // 12.height,
                          ],
                          //  if (canCancelOrder(order) || canOrderAgain(order))
                          // if (canCancelOrder(order))
                          //   CustomGrayButton(
                          //     text: canCancelOrder(order)
                          //         ? S.of(context).cancelOrder
                          //         : S.of(context).orderAgain,
                          //     isLoading: state.status.isLoading,
                          //     isActive: canCancelOrder(order),
                          //     onTap: () {
                          //       if (canCancelOrder(order)) {
                          //         confirmAlertDialog(
                          //           context,
                          //           title:
                          //               S.of(context).cancel_order_confirmation,
                          //           onYesTap: () {
                          //             Navigator.pop(context);
                          //             context.read<OrderCubit>().cancelOrder(
                          //                 orderId: order.id.toString());
                          //           },
                          //         );
                          //       } else if (canOrderAgain(order)) {}
                          //     },
                          //   ),
                        ],
                      ),
                    );
                  },
                ),
                body: RefreshIndicator(
                  onRefresh: () async {
                    await context
                        .read<OrderHistoryCubit>()
                        .fetchOrderById(orderId);
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        buildOrderInfo(context, order),
                        12.height,
                        OrderProductsWidget(orderInfo: order),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Container buildOrderInfo(BuildContext context, OrderHistoryEntity orderInfo) {
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
              orderInfo.paymentTypeId == 2
                  ? orderInfo.lastNumbers != null
                      ? '${orderInfo.issuer} ~ ${orderInfo.lastNumbers}'
                      : S.of(context).card_pay
                  : S.of(context).cashToCourier,
              style: AppTextStyle.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
