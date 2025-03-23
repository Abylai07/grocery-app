import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/domain/entity/user/app_config_entity.dart';
import 'package:abricoz_app/src/presentation/view/basket/widgets/product_changed_alert.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/app_router/app_router.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../common/utils/shared_preference.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/status_cubit.dart';
import '../../../widgets/buttons/main_button.dart';
import '../../../widgets/modal_bottoms/non_authorize_modal.dart';
import '../../../widgets/padding_nav_buttons.dart';
import '../../../widgets/show_error_snackbar.dart';
import '../bloc/basket_bloc/basket_bloc.dart';

class MakeOrderButton extends StatelessWidget {
  const MakeOrderButton({
    super.key,
    this.showWhenUpMinPrice = false,
  });
  final bool showWhenUpMinPrice;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, BaseState>(
      builder: (context, price) {
        int minPrice = 5000;
        if(price.status.isSuccess){
          AppConfigEntity settings = price.entity;
          minPrice = settings.minOrderAmount;
        }

        return BlocConsumer<BasketBloc, BasketState>(
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
              if (state.isCartChanged) {
                productChangedAlert(
                  context,
                  entity: state.entity!,
                  onYesTap: () {
                    Navigator.pop(context);
                    if (state.basketSum >= minPrice) {
                      context.router.push(MakeOrderRoute(
                        products: state.allProducts!,
                        productSum: state.basketSum,
                      ));
                    } else {
                      showErrorSnackBar(context,
                          S.of(context).minimum_order_amount(minPrice));
                    }
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
            if (showWhenUpMinPrice && state.basketSum < minPrice) {
              return const SizedBox();
            }

            return state.allProducts != null && state.allProducts!.isNotEmpty
                ? PaddingForNavButtons(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state.basketSum < minPrice)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              S.of(context).minimum_order_amount(minPrice),
                              style: AppTextStyle.bodyLarge,
                            ),
                          ),
                        CustomMainButton(
                          text: S.of(context).goToPay('${state.basketSum}'),
                          isActive: state.basketSum >= minPrice,
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
                    ),
                  )
                : const SizedBox();
          },
        );
      },
    );
  }
}
