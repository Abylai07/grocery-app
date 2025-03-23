import 'dart:io';

import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/app_styles/colors.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/domain/entity/user/app_config_entity.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:abricoz_app/src/presentation/widgets/buttons/main_button.dart';
import 'package:abricoz_app/src/presentation/widgets/padding_nav_buttons.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../get_it_sl.dart';
import '../../../bloc/status_cubit.dart';
import '../../../widgets/snack_bar.dart';

@RoutePage()
class TechnicalWorkScreen extends StatelessWidget {
  const TechnicalWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;

    return BlocProvider(
      create: (context) => AppSettingsCubit(sl()),
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BlocConsumer<AppSettingsCubit, BaseState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              AppConfigEntity entity = state.entity;
              if (entity.isAppActive) {
                context.router.replaceAll([const IndexRoute()]);
              } else {
                showSnackBar(
                  context,
                  S.of(context).technicalStill,
                  image: AppAssets.cancel,
                );
              }
            }
          },
          builder: (context, state) {
            return PaddingForNavButtons(
              child: CustomMainButton(
                isLoading: state.status.isLoading,
                height: 52,
                text: S.of(context).check_status,
                onTap: () {
                  context.read<AppSettingsCubit>().fetchAppStatus();
                },
              ),
            );
          },
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double imageHeight = constraints.maxHeight -
                appBarHeight -
                kBottomNavigationBarHeight;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      S.of(context).maintenance_title,
                      style: AppTextStyle.titleMedium
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Text(
                        S.of(context).maintenance_description,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bodyLarge
                            .copyWith(color: AppColors.textGray),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Image.asset(
                    AppAssets.upgradeApp,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
