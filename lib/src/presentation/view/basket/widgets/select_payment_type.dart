import 'package:abricoz_app/src/common/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';

class SelectPaymentType extends StatelessWidget {
  const SelectPaymentType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
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
              24.height,
              Row(
                children: [
                  SvgPicture.asset(AppAssets.cash),
                  12.width,
                  Expanded(
                      child: Text(
                        S.of(context).cashToCourier,
                        style: AppTextStyle.bodyLarge,
                      )),
                  SvgPicture.asset(AppAssets.selected),
                ],
              ),
              const Divider(
                height: 32,
                color: AppColors.grayContainer,
              ),
              Opacity(
                opacity: 0.5,
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssets.card),
                    12.width,
                    Expanded(
                      child: Text(
                        'Kaspi Gold',
                        style: AppTextStyle.bodyLarge,
                      ),
                    ),
                  //  SvgPicture.asset(AppAssets.selected),
                  ],
                ),
              ),
              const Divider(
                height: 32,
                color: AppColors.grayContainer,
              ),
              Opacity(
                opacity: 0.5,
                child: TextButton(
                    onPressed: () {},
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
          ),
        ),
      ),
    );
  }
}