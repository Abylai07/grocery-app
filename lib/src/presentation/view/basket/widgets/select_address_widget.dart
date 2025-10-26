import 'package:grocery_app/src/common/enums.dart';
import 'package:grocery_app/src/domain/entity/user/address_entity.dart';
import 'package:grocery_app/src/presentation/view/profile/bloc/address_bloc/address_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/app_router/app_router.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';

class SelectAddressWidget extends StatelessWidget {
  const SelectAddressWidget({
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).deliveryBefore,
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
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  if (state.status.isSuccess) {
                    List<AddressEntity> addresses = state.entity ?? [];
                    return Column(
                      children: [
                        addresses.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Text(
                                  S.of(context).noAddress,
                                  style: AppTextStyle.titleSmall,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: addresses.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<AddressCubit>()
                                              .selectAddress(addresses[index]);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                '${addresses[index].streetAndHouse}, ${addresses[index].apartment}',
                                                style: AppTextStyle.bodyLarge,
                                              )),
                                              if (addresses[index].id ==
                                                  state.selectAddress?.id)
                                                SvgPicture.asset(
                                                    AppAssets.selected),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        height: 12,
                                        color: AppColors.grayContainer,
                                      ),
                                    ],
                                  );
                                }),
                        TextButton(
                            onPressed: () async {
                              if(addresses.isEmpty){
                                await context.router.push(MapAddressRoute());
                                context.read<AddressCubit>().fetchAddress();
                              } else {
                                context.router.push(const AddressRoute());
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  addresses.isEmpty
                                      ? S.of(context).addNewAddress
                                      : S.of(context).changeAddress,
                                  style: AppTextStyle.bodyMedium.copyWith(
                                    color: AppColors.main,
                                  ),
                                ),
                                6.width,
                                addresses.isEmpty
                                    ? const Icon(
                                        Icons.add,
                                        color: AppColors.main,
                                      )
                                    : SvgPicture.asset(
                                        AppAssets.redact,
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.main, BlendMode.srcIn),
                                      ),
                              ],
                            )),
                      ],
                    );
                  } else if (state.status.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
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
