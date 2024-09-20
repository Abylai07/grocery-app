import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/domain/entity/order/order_history_entity.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:abricoz_app/src/presentation/view/basket/bloc/basket_bloc/basket_bloc.dart';
import 'package:abricoz_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/app_styles/assets.dart';
import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../widgets/main_functions.dart';
import '../../bloc/order_history_cubit.dart';

@RoutePage()
class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrderHistoryCubit>().fetchOrderHistory();

    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).myOrders,
      ),
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () {
          context.read<OrderHistoryCubit>().fetchOrderHistory();
          return Future.delayed(const Duration(seconds: 2));
        },
        child: BlocBuilder<OrderHistoryCubit, BaseState>(
          builder: (context, state) {
            List<OrderHistoryEntity> orders = state.entity ?? [];
            if (state.status.isSuccess && orders.isNotEmpty) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        context.router.push(OrderDetailRoute(orderInfo: orders[index]));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${S.of(context).order} №${orders[index].id}',
                                  style: AppTextStyle.bodyMedium,
                                ),
                                Text(
                                  '${orders[index].totalPrice.toInt()} ₸',
                                  style: AppTextStyle.bodyMedium
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            12.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDate(orders[index].createdAt),
                                  style: AppTextStyle.bodyMedium
                                      .copyWith(color: AppColors.gray),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.grayContainer,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Text(
                                  orders[index].orderStatus.name,
                                  style: AppTextStyle.bodyMedium,
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else if (state.status.isSuccess && orders.isEmpty) {
              return buildEmptyHistory(context);
            } else if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget buildEmptyHistory(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42.0),
            child: Image.asset(AppAssets.historyEmpty),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 12),
            child: Text(
              S.of(context).orderEmpty,
              style:
                  AppTextStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            S.of(context).lastOrderWillHere,
            style: AppTextStyle.bodyLarge.copyWith(color: AppColors.textGray),
            textAlign: TextAlign.center,
          ),
          16.height,
          InkWell(
            onTap: () async {
              final list = context.read<BasketBloc>().state.allProducts ?? [];
              context.router.replaceAll([IndexRoute(children: [list.isNotEmpty ? const BasketRoute() : const HomeNestedRoute()])]);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.main,
              ),
              child: Text(
                S.of(context).goToProducts,
                style: AppTextStyle.bodyLarge.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
