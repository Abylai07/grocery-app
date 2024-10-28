import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:abricoz_app/src/presentation/view/favorite/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/user_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/widgets/change_language_widget.dart';
import 'package:abricoz_app/src/presentation/view/profile/widgets/profile_element_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../common/app_styles/colors.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../common/utils/parsers/date_parser.dart';
import '../../widgets/alert_dialog/text_alert_dialog.dart';
import '../../widgets/modal_bottoms/non_authorize_modal.dart';
import 'bloc/user_session_bloc.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(S.of(context).profile),
        centerTitle: true,
        actions: [
          BlocBuilder<UserSessionBloc, UserSessionState>(
            builder: (context, state) {
              if (state is UserSessionLoaded) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: IconButton(
                    onPressed: () {
                      confirmAlertDialog(context,
                          title: S.of(context).deleteAccountSure, onYesTap: () {
                        context.read<UserCubit>().deleteAccount();
                        Navigator.pop(context);
                        context
                            .read<UserSessionBloc>()
                            .add(LogoutUserSession());
                        context.router.replaceAll([const IndexRoute()]);
                      });
                    },
                    icon: SvgPicture.asset(
                      AppAssets.remove,
                      colorFilter: const ColorFilter.mode(
                          AppColors.redColor, BlendMode.srcIn),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  BlocConsumer<UserSessionBloc, UserSessionState>(
                    listener: (BuildContext context, UserSessionState state) {
                      if(state is UserSessionLoggedOut){
                        context.read<FavoriteCubit>().setInitState();
                      }
                    },
                    builder: (context, state) {
                      if (state is UserSessionLoaded) {
                        return Column(
                          children: [
                            ProfileElementWidget(
                              title:
                                  '+7 ${AppUtils.phoneMaskFormatter.maskText(SharedPrefs().getPhone() ?? '')}',
                              icon: AppAssets.account,
                              onPressed: () {},
                            ),
                            ProfileElementWidget(
                              title: S.of(context).logout,
                              icon: AppAssets.logout,
                              logout: true,
                              onPressed: () {
                                confirmAlertDialog(
                                  context,
                                  title: S.of(context).sureLogout,
                                  onYesTap: () {
                                    Navigator.pop(context);
                                    context
                                        .read<UserSessionBloc>()
                                        .add(LogoutUserSession());
                                    context.router
                                        .replaceAll([const IndexRoute()]);
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      } else {
                        return ProfileElementWidget(
                          title: S.of(context).loginAccount,
                          icon: AppAssets.account,
                          onPressed: () {
                            context.router.push(const SignInRoute());
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ProfileElementWidget(
                    title: S.of(context).address,
                    icon: AppAssets.address,
                    onPressed: () {
                      if (SharedPrefs().getAccessToken() == null) {
                        nonAuthorizeModal(context);
                      } else {
                        context.router.push(const AddressRoute());
                      }
                    },
                  ),
                  ProfileElementWidget(
                    title: S.of(context).orders,
                    icon: AppAssets.orders,
                    onPressed: () {
                      if (SharedPrefs().getAccessToken() == null) {
                        nonAuthorizeModal(context);
                      } else {
                        context.router.push(const OrderHistoryRoute());
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ProfileElementWidget(
                    title: S.of(context).appLanguage,
                    icon: AppAssets.language,
                    isLanguage: true,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        builder: (context) {
                          return const ChangeLanguageWidget();
                        },
                      );
                    },
                  ),
                  // ProfileElementWidget(
                  //   title: S.of(context).deleteAccount,
                  //   icon: AppAssets.remove,
                  //   logout: true,
                  //   onPressed: () {
                  //     confirmAlertDialog(
                  //       context,
                  //       title: S.of(context).deleteAccountSure,
                  //       onYesTap: () {
                  //         context.read<UserCubit>().deleteAccount();
                  //         Navigator.pop(context);
                  //         context
                  //             .read<UserSessionBloc>()
                  //             .add(LogoutUserSession());
                  //         context.router.replaceAll([
                  //           const IndexRoute(children: [HomeNestedRoute()])
                  //         ]);
                  //       },
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
            24.height,
            FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (ctx, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return Text(
                        ' ${S.of(context).version} ${snapshot.data?.version ?? '1.0.0'}',
                        style: AppTextStyle.labelMedium.copyWith(
                          color: AppColors.textGray,
                        ),
                      );
                    default:
                      return const SizedBox();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
