import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/app_styles/assets.dart';
import '../../common/app_styles/colors.dart';
import '../../common/utils/l10n/generated/l10n.dart';
import '../bloc/nav_bar_bloc.dart';

@RoutePage()
class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double bottom = MediaQuery.of(context).viewInsets.bottom;

    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        BasketRoute(),
        FavoriteRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: child,
          bottomNavigationBar: BlocBuilder<NavBarBloc, NavBarState>(
            builder: (context, state) {
              return AnimatedContainer(
                margin: EdgeInsets.only(bottom: state.isVisible ? MediaQuery.of(context).padding.bottom : 0),
                duration: const Duration(milliseconds: 300),
                height: state.isVisible ? kBottomNavigationBarHeight : 0,
                child: Wrap(
                  children: [
                    BottomNavigationBar(
                      unselectedLabelStyle: AppTextStyle.displayMedium.copyWith(fontWeight: FontWeight.w500),
                      selectedLabelStyle: AppTextStyle.displayMedium.copyWith(fontWeight: FontWeight.w500),
                      type: BottomNavigationBarType.fixed,
                      currentIndex: tabsRouter.activeIndex,
                      onTap: (value) async {
                        tabsRouter.setActiveIndex(value);
                      },
                      iconSize: 26,
                      items: [
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(AppAssets.icon1),
                          activeIcon: SvgPicture.asset(AppAssets.iconActive1),
                          label: S.of(context).main,
                        ),
                        BottomNavigationBarItem(
                          icon: getBadgetIcon(false),
                          activeIcon: getBadgetIcon(true),
                          label: S.of(context).basket,
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(AppAssets.icon4),
                          activeIcon: SvgPicture.asset(AppAssets.iconActive4),
                          label: S.of(context).favorite,
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(AppAssets.icon5),
                          activeIcon: SvgPicture.asset(AppAssets.iconActive5),
                          label: S.of(context).profile,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }


  Widget getBadgetIcon(bool active) {
    // return state <= 0
    //     ? getIcon(index)
    //     : b.Badge(
    //   position: BadgePosition.topEnd(top: -5, end: -5),
    //   badgeAnimation: const BadgeAnimation.slide(
    //       colorChangeAnimationDuration:
    //       const Duration(milliseconds: 300)),
    //   badgeContent: Text(
    //     state.toString(),
    //     style: Theme.of(ctx)
    //         .textTheme
    //         .bodyMedium
    //         ?.copyWith(color: Colors.white, fontSize: 10),
    //   ),
    //   child: getIcon(index),
    // );
    return badges.Badge(
          position: BadgePosition.topEnd(top: -12, end: -10),
          badgeAnimation: const BadgeAnimation.slide(
              colorChangeAnimationDuration: Duration(milliseconds: 300),
          ),
          badgeContent: Text(
            '2',
            style: AppTextStyle.labelSmall.copyWith(color: AppColors.white),
          ),
          child: SvgPicture.asset(active ? AppAssets.iconActive3 : AppAssets.icon3),
        );
  }
}
