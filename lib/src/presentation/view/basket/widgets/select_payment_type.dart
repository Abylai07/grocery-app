import 'package:grocery_app/src/common/enums.dart';
import 'package:grocery_app/src/common/utils/app_router/app_router.dart';
import 'package:grocery_app/src/common/utils/shared_preference.dart';
import 'package:grocery_app/src/domain/entity/user/app_config_entity.dart';
import 'package:grocery_app/src/presentation/bloc/base_state.dart';
import 'package:grocery_app/src/presentation/bloc/status_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/user/card_entity.dart';
import '../../profile/bloc/my_cards/cards_cubit.dart';

class SelectPaymentWidget extends StatelessWidget {
  const SelectPaymentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List roles = SharedPrefs().getRoles() ?? [];
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).paymentType,
                    style: AppTextStyle.titleBold,
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.textGray,
                    ),
                  )
                ],
              ),
              16.height,
              BlocBuilder<AppSettingsCubit, BaseState>(
                builder: (context, state) {
                  if (state.status.isSuccess) {
                    AppConfigEntity settings = state.entity;

                    return BlocBuilder<CardsCubit, CardsState>(
                      builder: (context, state) {
                        if (state.status.isSuccess) {
                          if (state.paymentType == PaymentType.none) {
                            return Text(
                              S.of(context).temporarily_not_accepting_orders,
                              style: AppTextStyle.bodyMedium
                                  .copyWith(color: Colors.red),
                            );
                          }

                          List<CardEntity> cards = state.entity ?? [];
                          return Column(
                            children: [
                              if (roles.contains('admin') ||
                                  settings.isCashPaymentActive) ...[
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<CardsCubit>()
                                        .selectPaymentType(PaymentType.cash);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.cash),
                                        12.width,
                                        Expanded(
                                            child: Text(
                                          S.of(context).cashToCourier,
                                          style: AppTextStyle.bodyLarge,
                                        )),
                                        if (state.paymentType.isCash)
                                          SvgPicture.asset(AppAssets.selected),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 16,
                                  color: AppColors.grayContainer,
                                ),
                              ],
                              cards.isNotEmpty && settings.isBankPaymentActive
                                  ? ListView.builder(
                                      itemCount: cards.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        bool isSelected =
                                            state.paymentType.isCard &&
                                                state.selectCard?.id ==
                                                    cards[index].id;
                                        return Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<CardsCubit>()
                                                    .selectCard(cards[index]);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppAssets.card),
                                                    12.width,
                                                    Expanded(
                                                        child: RichText(
                                                      text: TextSpan(
                                                        text:
                                                            cards[index].issuer,
                                                        style: AppTextStyle
                                                            .bodyLarge,
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                ' ~ ${cards[index].lastNumbers}',
                                                            style: AppTextStyle
                                                                .bodyLarge,
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                    if (isSelected)
                                                      SvgPicture.asset(
                                                          AppAssets.selected),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              height: 16,
                                              color: AppColors.grayContainer,
                                            ),
                                          ],
                                        );
                                      })
                                  : settings.isBankPaymentActive
                                      ? Column(
                                          children: [
                                            Image.asset(
                                              AppAssets.noCard,
                                              height: 100,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 12),
                                              child: Text(
                                                S.of(context).no_saved_cards,
                                                style: AppTextStyle.titleMedium
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                              Opacity(
                                opacity: settings.isBankPaymentActive ? 1 : 0.5,
                                child: TextButton(
                                    onPressed: () {
                                      if (settings.isBankPaymentActive) {
                                        context.router
                                            .push(const MyCardsRoute());
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          S.of(context).addNewCard,
                                          style:
                                              AppTextStyle.bodyMedium.copyWith(
                                            color: AppColors.main,
                                          ),
                                        ),
                                        4.width,
                                        const Icon(
                                          Icons.add,
                                          color: AppColors.main,
                                        )
                                      ],
                                    )),
                              )
                            ],
                          );
                        } else if (state.status.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  } else if (state.status.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
