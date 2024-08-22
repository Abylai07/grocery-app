import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/domain/entity/user/address_entity.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:abricoz_app/src/presentation/bloc/button_bloc/button_bloc.dart';
import 'package:abricoz_app/src/presentation/view/home/bloc/city_bloc/city_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/address_bloc/address_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/district_bloc/district_cubit.dart';
import 'package:abricoz_app/src/presentation/widgets/buttons/main_button.dart';
import 'package:abricoz_app/src/presentation/widgets/padding_nav_buttons.dart';
import 'package:abricoz_app/src/presentation/widgets/show_error_snackbar.dart';
import 'package:abricoz_app/src/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../get_it_sl.dart';
import '../../../../widgets/border_container.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/expandable_theme.dart';

@RoutePage()
class AddOrChangeAddressScreen extends StatelessWidget {
  const AddOrChangeAddressScreen({super.key, this.address});
  final AddressEntity? address;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              DistrictCubit(sl())..fetchDistricts(address?.districtId),
        ),
        BlocProvider(
          create: (_) => AddressCubit(sl()),
        ),
        BlocProvider(
          create: (_) => ButtonBloc(),
        ),
      ],
      child: AddOrChangeAddressView(
        address: address,
      ),
    );
  }
}

class AddOrChangeAddressView extends StatelessWidget {
  const AddOrChangeAddressView({super.key, this.address});
  final AddressEntity? address;

  @override
  Widget build(BuildContext context) {
    ExpandableController cityController = ExpandableController();
    ExpandableController districtController = ExpandableController();
    TextEditingController streetController =
        TextEditingController(text: address?.streetAndHouse);
    TextEditingController houseController =
        TextEditingController(text: address?.apartment);
    TextEditingController entranceController =
        TextEditingController(text: address?.entrance);
    TextEditingController floorController =
        TextEditingController(text: address?.floor);
    TextEditingController commentController =
        TextEditingController(text: address?.addressComment);
    bool isChangeAddress = address != null;

    checkFillField() {
      final buttonBloc = context.read<ButtonBloc>();
      bool buttonActive = buttonBloc.state is ButtonActive;
      if (!buttonActive &&
          streetController.text.isNotEmpty &&
          houseController.text.isNotEmpty) {
        buttonBloc.add(const ToggleButton(isActive: true));
      } else if (buttonActive &&
          (streetController.text.isEmpty || houseController.text.isEmpty)) {
        buttonBloc.add(const ToggleButton(isActive: false));
      }
    }

    onSavePressed() {
      int? cityId = context.read<CityCubit>().state.selectCity?.id;
      int? districtId = context.read<DistrictCubit>().state.selectDistrict?.id;
      context.read<AddressCubit>().addAddress(addressId: address?.id, data: {
        "city_id": cityId,
        "district_id": districtId,
        "address_street_and_house": streetController.text,
        "address_apartment": houseController.text,
        "address_entrance": entranceController.text,
        "address_floor": floorController.text,
        "address_comment": commentController.text,
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isChangeAddress) {
        checkFillField();
      }
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: isChangeAddress
            ? S.of(context).editAddress
            : S.of(context).addNewAddress,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).city,
                style: AppTextStyle.bodyLarge,
              ),
              BorderContainer(
                margin: const EdgeInsets.only(top: 4, bottom: 12),
                child: BlocBuilder<CityCubit, CityState>(
                  builder: (context, state) {
                    return ExpandablePanel(
                      controller: cityController,
                      theme: buildExpandableThemeData(),
                      header: Text(
                        state.selectCity?.name ?? 'Select city',
                        style: AppTextStyle.bodyMedium,
                      ),
                      collapsed: const SizedBox(),
                      expanded: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.entity?.length,
                        itemBuilder: (context, i) {
                          bool select =
                              state.entity?[i].id == state.selectCity?.id;
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<CityCubit>()
                                    .selectCity(state.entity?[i]);
                                cityController.value = false;
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.entity?[i].name ?? '',
                                    style: AppTextStyle.labelLarge.copyWith(
                                        color: select
                                            ? AppColors.main
                                            : AppColors.gray2),
                                  ),
                                  if (select)
                                    SvgPicture.asset(AppAssets.selected),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Text(
                S.of(context).district,
                style: AppTextStyle.bodyLarge,
              ),
              BorderContainer(
                margin: const EdgeInsets.only(top: 4, bottom: 12),
                child: BlocBuilder<DistrictCubit, DistrictState>(
                  builder: (context, state) {
                    if (state.status.isSuccess) {
                      return ExpandablePanel(
                        controller: districtController,
                        theme: buildExpandableThemeData(),
                        header: Text(
                          state.selectDistrict?.name ?? 'Select city',
                          style: AppTextStyle.bodyMedium,
                        ),
                        collapsed: const SizedBox(),
                        expanded: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.entity?.length,
                          itemBuilder: (context, i) {
                            bool select =
                                state.entity?[i].id == state.selectDistrict?.id;
                            return Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<DistrictCubit>()
                                      .selectDistrict(state.entity?[i]);
                                  districtController.value = false;
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.entity?[i].name ?? '',
                                      style: AppTextStyle.labelLarge.copyWith(
                                          color: select
                                              ? AppColors.main
                                              : AppColors.gray2),
                                    ),
                                    if (select)
                                      SvgPicture.asset(AppAssets.selected),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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
              ),
              CustomTextFieldWidget(
                controller: streetController,
                hintText: S.of(context).street,
                onChanged: (val) {
                  checkFillField();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWidget(
                        controller: houseController,
                        hintText: S.of(context).office,
                        onChanged: (val) {
                          checkFillField();
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomTextFieldWidget(
                          controller: entranceController,
                          hintText: S.of(context).entrance,
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextFieldWidget(
                        controller: floorController,
                        hintText: S.of(context).floor,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomTextFieldWidget(
                controller: commentController,
                hintText: S.of(context).commentToAddress,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PaddingForNavButtons(
        child: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.router.maybePop('refreshPage');
            } else if (state.status.isError) {
              showErrorSnackBar(context, S.of(context).somethingError);
            }
          },
          builder: (context, state) {
            return BlocBuilder<ButtonBloc, ButtonState>(
              builder: (context, buttonState) {
                return CustomMainButton(
                  isActive: buttonState is ButtonActive,
                  text: isChangeAddress
                      ? S.of(context).save
                      : S.of(context).addAddress,
                  isLoading: state.status.isLoading,
                  onTap: onSavePressed,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
