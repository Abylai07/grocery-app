import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/presentation/view/basket/widgets/active_orders_widget.dart';
import 'package:abricoz_app/src/presentation/view/basket/widgets/basket_item_widget.dart';
import 'package:abricoz_app/src/presentation/view/basket/widgets/make_order_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../data/hive/adapter/product_adapter.dart';
import '../../widgets/alert_dialog/text_alert_dialog.dart';
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
      bottomNavigationBar: const MakeOrderButton(),
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
                                    child: BasketItemWidget(
                                      product: product,
                                    ),
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


