import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../bloc/payment_type_bloc.dart';

class SelectPaymentWidget extends StatelessWidget {
  const SelectPaymentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> roles = SharedPrefs().getRoles() ?? [];
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<PaymentTypeBloc, PaymentTypeState>(
            builder: (context, state) {
              return Column(
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
                  if (roles.contains('admin')) ...[
                    InkWell(
                      onTap: () {
                        context
                            .read<PaymentTypeBloc>()
                            .add(const SelectPaymentType(PaymentType.cash));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppAssets.cash),
                            12.width,
                            Expanded(
                                child: Text(
                              S.of(context).cashToCourier,
                              style: AppTextStyle.bodyLarge,
                            )),
                            if (state.selectedPaymentType.isCash)
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
                  InkWell(
                    onTap: () {
                      context
                          .read<PaymentTypeBloc>()
                          .add(const SelectPaymentType(PaymentType.card));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppAssets.card),
                          12.width,
                          Expanded(
                            child: Text(
                              S.of(context).card_pay,
                              style: AppTextStyle.bodyLarge,
                            ),
                          ),
                          if (state.selectedPaymentType.isCard)
                            SvgPicture.asset(AppAssets.selected),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 32,
                    color: AppColors.grayContainer,
                  ),
                  TextButton(
                      onPressed: () {
                        context.router.push(const SaveCardRoute());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).addNewCard,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.main,
                            ),
                          ),
                          4.width,
                          const Icon(
                            Icons.add,
                            color: AppColors.main,
                          )
                        ],
                      ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
