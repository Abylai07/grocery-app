import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/domain/entity/user/address_entity.dart';
import 'package:abricoz_app/src/presentation/bloc/button_bloc/button_bloc.dart';
import 'package:abricoz_app/src/presentation/view/home/bloc/city_bloc/city_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/address_bloc/address_cubit.dart';
import 'package:abricoz_app/src/presentation/widgets/alert_dialog/text_alert_dialog.dart';
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
import '../../../../../data/models/user/yandex_address.dart';
import '../../../../../get_it_sl.dart';
import '../../../../widgets/border_container.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/expandable_theme.dart';

@RoutePage()
class AddOrChangeAddressScreen extends StatelessWidget {
  const AddOrChangeAddressScreen({
    super.key,
    this.address,
    required this.selectAddress,
  });
  final AddressEntity? address;
  final YandexAddress selectAddress;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AddressCubit(sl()),
        ),
        BlocProvider(
          create: (_) => ButtonBloc(),
        ),
      ],
      child: AddOrChangeAddressView(
        address: address,
        selectAddress: selectAddress,
      ),
    );
  }
}

class AddOrChangeAddressView extends StatefulWidget {
  const AddOrChangeAddressView({
    super.key,
    this.address,
    required this.selectAddress,
  });
  final AddressEntity? address;
  final YandexAddress selectAddress;

  @override
  State<AddOrChangeAddressView> createState() => _AddOrChangeAddressViewState();
}

class _AddOrChangeAddressViewState extends State<AddOrChangeAddressView> {
  late ExpandableController cityController;
  late TextEditingController streetController;
  late TextEditingController houseController;
  late TextEditingController entranceController;
  late TextEditingController floorController;
  late TextEditingController commentController;
  late bool isChangeAddress;

  @override
  void initState() {
    super.initState();

    cityController = ExpandableController();
    streetController = TextEditingController(text: widget.selectAddress.street);
    houseController = TextEditingController(text: widget.address?.apartment);
    entranceController = TextEditingController(text: widget.address?.entrance);
    floorController = TextEditingController(text: widget.address?.floor);
    commentController =
        TextEditingController(text: widget.address?.addressComment);

    isChangeAddress = widget.address != null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkFillField();
    });
  }

  @override
  void dispose() {
    cityController.dispose();
    streetController.dispose();
    houseController.dispose();
    entranceController.dispose();
    floorController.dispose();
    commentController.dispose();
    super.dispose();
  }

  checkFillField() {
    final buttonBloc = context.read<ButtonBloc>();
    bool buttonActive = buttonBloc.state is ButtonActive;
    if (!buttonActive && streetController.text.isNotEmpty) {
      buttonBloc.add(const ToggleButton(isActive: true));
    } else if (buttonActive && streetController.text.isEmpty) {
      buttonBloc.add(const ToggleButton(isActive: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    onSavePressed() {
      int? cityId = context.read<CityCubit>().state.selectCity?.id;
      context
          .read<AddressCubit>()
          .addAddress(addressId: widget.address?.id, data: {
        "city_id": cityId,
        "address_street_and_house": streetController.text,
        "address_apartment": houseController.text,
        "address_entrance": entranceController.text,
        "address_floor": floorController.text,
        "address_comment": commentController.text,
        "latitude": widget.selectAddress.latitude.toString(),
        "longitude": widget.selectAddress.longitude.toString(),
      });
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: isChangeAddress
            ? S.of(context).editAddress
            : S.of(context).addNewAddress,
        actions: [
          if (widget.address != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {
                  confirmAlertDialog(context,
                      title: S.of(context).deleteAddress, onYesTap: () {
                    context.router.popUntil(
                        (route) => route.settings.name == AddressRoute.name);
                    context
                        .read<AddressCubit>()
                        .deleteAddress(widget.address?.id);
                  });
                },
                icon: SvgPicture.asset(AppAssets.remove),
              ),
            ),
        ],
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
                    if (state.status.isSuccess) {
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
                    } else if (state.status.isLoading) {
                      return const Center(child: CircularProgressIndicator());
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
                        onChanged: (val) {},
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
              Navigator.pop(context);
              Navigator.pop(context);
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
                  onTap: () => onSavePressed(),
                  // onTap: () => context.router.push(const MapAddressRoute())// onSavePressed,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
