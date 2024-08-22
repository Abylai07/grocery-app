import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/domain/entity/user/address_entity.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/address_bloc/address_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../common/app_styles/assets.dart';
import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../widgets/custom_app_bar.dart';

@RoutePage()
class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).yourAddress,
      ),
      backgroundColor: AppColors.background,
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          if (state.status.isSuccess) {
            List<AddressEntity> addresses = state.entity ?? [];
            return addresses.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: addresses.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                            '${addresses[index].streetAndHouse}, ${addresses[index].apartment}',
                                        style: AppTextStyle.bodyLarge,
                                      )),
                                      IconButton(
                                        icon:
                                            SvgPicture.asset(AppAssets.redact),
                                        onPressed: () async {
                                          final result = await context.router
                                              .push(AddOrChangeAddressRoute(
                                                  address: addresses[index]));
                                          if (result == 'refreshPage') {
                                            context
                                                .read<AddressCubit>()
                                                .fetchAddress();
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    height: 16,
                                    color: AppColors.grayContainer,
                                  ),
                                ],
                              );
                            }),
                        TextButton(
                            onPressed: () async {
                              final result = await context.router
                                  .push(AddOrChangeAddressRoute());
                              if (result == 'refreshPage') {
                                context.read<AddressCubit>().fetchAddress();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).addNewAddress,
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
                    ),
                  )
                : buildEmptyAddress(context);
          } else if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Column buildEmptyAddress(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.0),
          child: Image.asset(AppAssets.addressEmpty),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 12),
          child: Text(
            S.of(context).noAddress,
            style:
                AppTextStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          S.of(context).addressSaveHere,
          style: AppTextStyle.bodyLarge.copyWith(color: AppColors.textGray),
          textAlign: TextAlign.center,
        ),
        16.height,
        InkWell(
          onTap: () async {
            final result = await context.router.push(AddOrChangeAddressRoute());
            if (result == 'refreshPage') {
              context.read<AddressCubit>().fetchAddress();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.main,
            ),
            child: Text(
              S.of(context).addNewAddress,
              style: AppTextStyle.bodyLarge.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
