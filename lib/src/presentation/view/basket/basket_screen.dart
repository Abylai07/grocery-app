import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:abricoz_app/src/presentation/view/basket/widgets/basket_item_widget.dart';
import 'package:abricoz_app/src/presentation/view/basket/widgets/product_changed_alert.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../data/hive/adapter/product_adapter.dart';
import '../../../domain/entity/order/order_history_entity.dart';
import '../../bloc/base_state.dart';
import '../../widgets/alert_dialog/text_alert_dialog.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/modal_bottoms/non_authorize_modal.dart';
import '../../widgets/padding_nav_buttons.dart';
import '../profile/bloc/order/active_orders_cubit.dart';
import 'bloc/basket_bloc/basket_bloc.dart';
import 'bloc/basket_button_bloc/basket_button_bloc.dart';

@RoutePage()
class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).basket),
        centerTitle: true,
        actions: [
          BlocBuilder<BasketBloc, BasketState>(
            builder: (context, state) {
              return state.allProducts != null && state.allProducts!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        onPressed: () {
                          confirmAlertDialog(
                            context,
                            title: S.of(context).deleteAllBasket,
                            onYesTap: () {
                              Navigator.pop(context);
                              context
                                  .read<BasketBloc>()
                                  .add(const DeleteAllBasket());
                            },
                          );
                        },
                        icon: SvgPicture.asset(AppAssets.remove),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ],
      ),
      bottomNavigationBar: PaddingForNavButtons(
        child: BlocConsumer<BasketBloc, BasketState>(
          listener: (context, state) {
            if (state.status.isSuccess && state.isCartChanged) {
              productChangedAlert(
                context,
                entity: state.entity!,
                onYesTap: () {
                  Navigator.pop(context);
                },
              );
            } else if (state.status.isReadyToOrder) {
              if (state.isCartChanged){
                productChangedAlert(
                  context,
                  entity: state.entity!,
                  onYesTap: () {
                    Navigator.pop(context);
                    context.router.push(MakeOrderRoute(
                      products: state.allProducts!,
                      productSum: state.basketSum,
                    ));
                  },
                );
              } else {
                context.router.push(MakeOrderRoute(
                  products: state.allProducts!,
                  productSum: state.basketSum,
                ));
              }
            }
          },
          builder: (context, state) {
            return state.allProducts != null && state.allProducts!.isNotEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.basketSum < 5000)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            S.of(context).minimum_order_amount,
                            style: AppTextStyle.bodyLarge,
                          ),
                        ),
                      CustomMainButton(
                        text: S.of(context).goToPay('${state.basketSum}'),
                        isActive: state.basketSum >= 5000,
                        isLoading: state.status.isOrderLoading,
                        onTap: () {
                          if (SharedPrefs().getAccessToken() != null) {
                            context.read<BasketBloc>().add(
                                const CheckBasketItems(readyToOrder: true));
                          } else {
                            nonAuthorizeModal(context);
                          }
                        },
                      ),
                    ],
                  )
                : const SizedBox();
          },
        ),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const ActiveOrderWidget(),
          BlocBuilder<BasketBloc, BasketState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }
              return state.allProducts?.isNotEmpty == true
                  ? Expanded(
                      child: Container(
                        color: AppColors.white,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          itemCount: state.allProducts?.length ?? 0,
                          itemBuilder: (context, index) {
                            ProductHiveModel? product =
                                state.allProducts?[index];
                            return product != null
                                ? BlocProvider(
                                    key: ValueKey(
                                        '${product.id}:${product.basketCount}'),
                                    create: (context) =>
                                        BasketButtonBloc(product),
                                    child: BasketItemWidget(product: product),
                                  )
                                : const SizedBox();
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 8);
                          },
                        ),
                      ),
                    )
                  : Expanded(child: buildEmptyBasket(context));
            },
          ),
        ],
      ),
    );
  }

  Widget buildEmptyBasket(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42.0),
            child: Image.asset(AppAssets.basketEmpty),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 12),
            child: Text(
              S.of(context).basketEmpty,
              style: AppTextStyle.titleMedium
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            S.of(context).hereWillProduct,
            style: AppTextStyle.bodyLarge.copyWith(color: AppColors.textGray),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ActiveOrderWidget extends StatelessWidget {
  const ActiveOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveOrdersCubit, BaseState>(
      builder: (context, orderState) {
        List<OrderHistoryEntity> orders = [];
        if (orderState.status.isSuccess) {
          orders = orderState.entity;
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
                                  OrderDetailRoute(orderInfo: orders[index]));
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
