import 'package:grocery_app/src/common/enums.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/app_router/app_router.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/order/order_history_entity.dart';
import '../../../bloc/base_state.dart';
import '../../profile/bloc/order/active_orders_cubit.dart';

class ActiveOrderWidget extends StatelessWidget {
  const ActiveOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveOrdersCubit, BaseState>(
      builder: (context, orderState) {
        List<OrderHistoryEntity> orders = [];
        if (orderState.entity is List<OrderHistoryEntity>) {
          List<OrderHistoryEntity> allOrders = orderState.entity as List<OrderHistoryEntity>;
          orders = allOrders.length > 3 ? allOrders.sublist(allOrders.length - 3) : allOrders;
        }
        return orders.isNotEmpty
            ? ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0XFFFCE8E5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                S.of(context).activeOrder,
                                style: AppTextStyle.labelSmall.copyWith(
                                    color: AppColors.main,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0XFFE1F2FE),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                orders[index].orderStatus.name,
                                style: AppTextStyle.labelSmall.copyWith(
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        4.height,
                        Text(
                          '${S.of(context).order} №${orders[index].id}',
                          style: AppTextStyle.bodyLarge
                              .copyWith(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        context.router.push(
                            OrderDetailRoute(orderId: orders[index].id));
                      },
                      child: Row(
                        children: [
                          Text(
                            S.of(context).go,
                            style: AppTextStyle.bodyMedium
                                .copyWith(color: AppColors.main),
                          ),
                          4.width,
                          SvgPicture.asset(
                            AppAssets.arrowNext,
                            colorFilter: const ColorFilter.mode(
                                AppColors.main, BlendMode.srcIn),
                          ),
                        ],
                      ))
                ],
              ),
            );
          },
        )
            : const SizedBox();
      },
    );
  }
}