import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:abricoz_app/src/common/utils/shared_preference.dart';
import 'package:abricoz_app/src/domain/entity/user/user_entity.dart';
import 'package:abricoz_app/src/presentation/bloc/base_state.dart';
import 'package:abricoz_app/src/presentation/view/favorite/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:abricoz_app/src/presentation/view/home/bloc/city_bloc/city_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/order/active_orders_cubit.dart';
import 'package:abricoz_app/src/presentation/view/profile/bloc/user_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upgrader/upgrader.dart';
import '../../common/app_styles/assets.dart';
import '../../common/app_styles/colors.dart';
import '../../common/utils/firebase_api/notifications.dart';
import '../../common/utils/l10n/generated/l10n.dart';
import '../../domain/entity/user/app_config_entity.dart';
import '../bloc/nav_bar_bloc.dart';
import '../bloc/status_cubit.dart';
import '../widgets/cache_file_mixin.dart';
import '../widgets/modal_bottoms/non_authorize_modal.dart';
import '../widgets/upgrader_widget.dart';
import 'authorization/user_info_screen.dart';
import 'basket/bloc/basket_bloc/basket_bloc.dart';

@RoutePage()
class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> with CacheFileMixin {
  @override
  void initState() {
    Notifications().init(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BasketBloc>().add(const RefreshBasket());
      context.read<CityCubit>().fetchCityList();
    });
    checkStorageUsage();
    super.initState();
  }

  checkUserBanAndEmail(UserEntity user) {
    if(user.isBanned){
      context.router.replaceAll([const BannedUserRoute()]);
    } else if (user.firstname == null || user.lastname == null || user.email == null) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: AppColors.white,
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.8,
            minChildSize: 0.7,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return const ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: UserInfoScreen(
                  isSignIn: false,
                ),
              );
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        BasketRoute(),
        FavoriteRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return UpgradeWidget(
          dialogStyle: UpgradeDialogStyle.cupertino,
          showIgnore: false,
          showLater: false,
          upgrader: Upgrader(
            durationUntilAlertAgain: const Duration(seconds: 10),
            debugLogging: true,
          ),
          child: MultiBlocListener(
            listeners: [
              BlocListener<AppSettingsCubit, BaseState>(
                listener: (context, state) {
                  if (state.status.isSuccess) {
                    AppConfigEntity entity = state.entity;
                    if (!entity.isAppActive) {
                      context.router.replaceAll([const TechnicalWorkRoute()]);
                    }
                  }
                },
              ),
              BlocListener<UserCubit, BaseState>(
                listener: (context, state) {
                  if (state.status.isSuccess) {
                    checkUserBanAndEmail(state.entity);
                  }
                },
              ),
            ],
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: child,
              bottomNavigationBar: BlocBuilder<NavBarBloc, NavBarState>(
                builder: (context, state) {
                  return AnimatedContainer(
                    margin: EdgeInsets.only(
                        bottom: state.isVisible
                            ? MediaQuery.of(context).padding.bottom
                            : 0),
                    duration: const Duration(milliseconds: 300),
                    height: state.isVisible ? kBottomNavigationBarHeight : 0,
                    child: Wrap(
                      children: [
                        BottomNavigationBar(
                          unselectedLabelStyle: AppTextStyle.displayMedium
                              .copyWith(fontWeight: FontWeight.w500),
                          selectedLabelStyle: AppTextStyle.displayMedium
                              .copyWith(fontWeight: FontWeight.w500),
                          type: BottomNavigationBarType.fixed,
                          currentIndex: tabsRouter.activeIndex,
                          onTap: (value) {
                            String? token = SharedPrefs().getAccessToken();
                            if (value == 1 && token != null) {
                              context
                                  .read<BasketBloc>()
                                  .add(const CheckBasketItems());
                              context
                                  .read<ActiveOrdersCubit>()
                                  .fetchActiveOrders();
                            } else if (value == 1 && token == null) {
                              context
                                  .read<BasketBloc>()
                                  .add(const RefreshBasket());
                            } else if (value == 2 && token == null) {
                              nonAuthorizeModal(context);
                              return;
                            } else if (value == 2 && token != null) {
                              context.read<FavoriteCubit>().checkFavorites();
                            }
                            tabsRouter.setActiveIndex(value);
                          },
                          iconSize: 26,
                          items: [
                            BottomNavigationBarItem(
                              icon: SvgPicture.asset(AppAssets.icon1),
                              activeIcon:
                                  SvgPicture.asset(AppAssets.iconActive1),
                              label: S.of(context).main,
                            ),
                            BottomNavigationBarItem(
                              icon: getBadgeIcon(false),
                              activeIcon: getBadgeIcon(true),
                              label: S.of(context).basket,
                            ),
                            BottomNavigationBarItem(
                              icon: SvgPicture.asset(AppAssets.icon4),
                              activeIcon:
                                  SvgPicture.asset(AppAssets.iconActive4),
                              label: S.of(context).favorite,
                            ),
                            BottomNavigationBarItem(
                              icon: SvgPicture.asset(AppAssets.icon5),
                              activeIcon:
                                  SvgPicture.asset(AppAssets.iconActive5),
                              label: S.of(context).profile,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getBadgeIcon(bool active) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        int count = state.allProducts?.length ?? 0;
        return count < 1
            ? SvgPicture.asset(active ? AppAssets.iconActive3 : AppAssets.icon3)
            : badges.Badge(
                position: BadgePosition.topEnd(top: -12, end: -10),
                badgeAnimation: const BadgeAnimation.slide(
                  colorChangeAnimationDuration: Duration(milliseconds: 300),
                ),
                badgeContent: Text(
                  count.toString(),
                  style:
                      AppTextStyle.labelSmall.copyWith(color: AppColors.white),
                ),
                child: SvgPicture.asset(
                  active ? AppAssets.iconActive3 : AppAssets.icon3,
                ),
              );
      },
    );
  }
}
