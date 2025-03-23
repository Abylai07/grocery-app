import 'package:abricoz_app/src/common/app_styles/colors.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/data/hive/adapter/product_adapter.dart';
import 'package:abricoz_app/src/presentation/view/basket/bloc/basket_bloc/basket_bloc.dart';
import 'package:abricoz_app/src/presentation/view/basket/bloc/delivery_time_bloc/delivery_time_cubit.dart';
import 'package:abricoz_app/src/presentation/view/basket/bloc/order_bloc/order_cubit.dart';
import 'package:abricoz_app/src/presentation/view/basket/widgets/select_address_widget.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/my_cards/cards_cubit.dart';
import 'package:abricoz_app/src/presentation/widgets/buttons/main_button.dart';
import 'package:abricoz_app/src/presentation/widgets/padding_nav_buttons.dart';
import 'package:abricoz_app/src/presentation/widgets/show_error_snackbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../get_it_sl.dart';
import '../../../bloc/status_cubit.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../profile/bloc/address_bloc/address_cubit.dart';
import '../widgets/select_payment_type.dart';

@RoutePage()
class MakeOrderScreen extends StatelessWidget {
  const MakeOrderScreen(
      {super.key, required this.products, required this.productSum});
  final List<ProductHiveModel> products;
  final num productSum;

  @override
  Widget build(BuildContext context) {
    context.read<AppSettingsCubit>().fetchAppStatus();
    context.read<CardsCubit>().fetchMyCards();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DeliveryTimeCubit(sl())..fetchDeliveryTime(),
        ),
        BlocProvider(
          create: (_) => OrderCubit(sl()),
        ),
      ],
      child: DeliveryTimeView(
        productSum: productSum,
        products: products,
      ),
    );
  }
}

class DeliveryTimeView extends StatelessWidget {
  const DeliveryTimeView({
    super.key,
    required this.products,
    required this.productSum,
  });
  final List<ProductHiveModel> products;
  final num productSum;

  @override
  Widget build(BuildContext context) {

    context.read<CardsCubit>().checkMyCards();
    String getFormattedDate(DateTime? dateTime) {
      if (dateTime == null) return '';

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(const Duration(days: 1));
      final inputDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (inputDate == today) {
        return S.of(context).today;
      } else if (inputDate == tomorrow) {
        return S.of(context).tomorrow;
      } else {
        return '${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}';
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).makeOrder,
      ),
      bottomNavigationBar: PaddingForNavButtons(
        child: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state.status.isSuccess && state.entity != null) {
              context.read<BasketBloc>().add(const DeleteAllBasket());
              context.router.popAndPush(PaymentRoute(orderId: state.entity!));
            } else if (state.status.isError) {
              showErrorSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            return CustomMainButton(
              isLoading: state.status.isLoading,
              text: S.of(context).confirmPay(productSum),
              onTap: () {
                final dateTime =
                    context.read<DeliveryTimeCubit>().state.selectTime;
                final addressId =
                    context.read<AddressCubit>().state.selectAddress?.id;
                final isCard =
                    context.read<CardsCubit>().state.paymentType.isCard;
                final cardId = context.read<CardsCubit>().state.selectCard?.id;
                if (dateTime == null ||
                    addressId == null ||
                    (cardId == null && isCard)) {
                  showErrorSnackBar(
                    context,
                    addressId == null
                        ? S.of(context).selectAddressPlease
                        : dateTime == null
                            ? S.of(context).selectTimePlease
                            : S.of(context).select_payment_method,
                  );
                } else {
                  context.read<OrderCubit>().createOrder(
                        time: dateTime,
                        addressId: addressId,
                        products: products,
                        paymentTypeId: isCard ? 2 : 1,
                        cardId: cardId,
                      );
                }
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).deliveryBefore,
              style: AppTextStyle.titleMedium
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            BlocBuilder<AddressCubit, AddressState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      builder: (context) {
                        return const SelectAddressWidget();
                      },
                    );
                  },
                  child: Container(
                    height: 62,
                    margin: const EdgeInsets.only(top: 8, bottom: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.grayContainer,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          child: state.selectAddress == null
                              ? Text(
                                  S.of(context).selectAddress,
                                  style: AppTextStyle.bodyMedium,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${state.selectAddress?.streetAndHouse}, ${state.selectAddress?.apartment}',
                                      style: AppTextStyle.bodyMedium,
                                    ),
                                    Text(
                                      S.of(context).delivery30min,
                                      style: AppTextStyle.labelMedium
                                          .copyWith(color: AppColors.textGray),
                                    )
                                  ],
                                ),
                        ),
                        SvgPicture.asset(AppAssets.arrowNext),
                      ],
                    ),
                  ),
                );
              },
            ),
            Text(
              S.of(context).deliveryTime,
              style: AppTextStyle.titleMedium
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            BlocBuilder<DeliveryTimeCubit, DeliveryTimeState>(
              builder: (context, state) {
                return Container(
                  height: 56,
                  margin: const EdgeInsets.only(top: 8, bottom: 24),
                  child: state.status.isSuccess
                      ? state.entity?.isEmpty == true
                          ? Center(
                              child: Text(
                              S.of(context).notAvailableNow,
                              style: AppTextStyle.bodyLarge,
                            ))
                          : ListView.builder(
                              itemCount:
                                  state.entity?.length, // state.entity?.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                bool isSelected = (state.entity?[index].id ==
                                        state.selectTime?.id) &&
                                    (state.entity?[index].date ==
                                        state.selectTime?.date);

                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<DeliveryTimeCubit>()
                                        .selectDeliveryTime(
                                            state.entity?[index]);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.lightOrange
                                          : AppColors.grayContainer,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.entity?[index].name ?? '',
                                          style: AppTextStyle.bodyMedium
                                              .copyWith(
                                                  color: isSelected
                                                      ? AppColors.main
                                                      : AppColors.black),
                                        ),
                                        Text(
                                          getFormattedDate(
                                              state.entity?[index].date),
                                          style: AppTextStyle.bodyMedium
                                              .copyWith(
                                                  color: isSelected
                                                      ? AppColors.main
                                                      : AppColors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                      : state.status.isLoading
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : const SizedBox(),
                );
              },
            ),
            Text(
              S.of(context).paymentType,
              style: AppTextStyle.titleMedium
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    builder: (context) {
                      return const SelectPaymentWidget();
                    });
              },
              child: BlocBuilder<CardsCubit, CardsState>(
                builder: (context, state) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 8, bottom: 24),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.lightGrey,
                        )),
                    child: state.status.isSuccess
                        ? Row(
                            children: [
                              SvgPicture.asset(state.paymentType.isCash
                                  ? AppAssets.cash
                                  : AppAssets.card),
                              12.width,
                              Expanded(
                                child: Text(
                                  state.paymentType.isCash
                                      ? S.of(context).cashToCourier
                                      : state.selectCard == null
                                          ? S.of(context).select_payment_method
                                          : '${state.selectCard?.issuer} ~ ${state.selectCard?.lastNumbers}',
                                  style: AppTextStyle.bodyMedium,
                                ),
                              ),
                              SvgPicture.asset(AppAssets.arrowNext)
                            ],
                          )
                        : const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).products,
                  style: AppTextStyle.bodyLarge,
                ),
                Text(
                  '$productSum ₸',
                  style: AppTextStyle.bodyLarge,
                ),
              ],
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).deliveryPrice,
                  style: AppTextStyle.bodyLarge,
                ),
                BlocBuilder<AddressCubit, AddressState>(
                  builder: (context, state) {
                    return Text(
                      '${state.selectAddress?.deliveryPrice ?? 0} ₸',
                      style: AppTextStyle.bodyLarge,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
