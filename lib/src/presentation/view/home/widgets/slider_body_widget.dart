import 'dart:async';

import 'package:abricoz_app/src/common/app_styles/assets.dart';
import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/domain/entity/user/banner_entity.dart';
import 'package:abricoz_app/src/domain/entity/user/city_model.dart';
import 'package:abricoz_app/src/presentation/view/home/bloc/city_bloc/city_cubit.dart';
import 'package:abricoz_app/src/presentation/widgets/main_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../bloc/base_state.dart';
import '../bloc/banner_cubit.dart';

class SliderBodyWidget extends StatefulWidget {
  const SliderBodyWidget({super.key});

  @override
  State<SliderBodyWidget> createState() => _SliderBodyWidgetState();
}

class _SliderBodyWidgetState extends State<SliderBodyWidget> with RouteAware {
  Timer? _timer;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: 1, keepPage: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe to route changes
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      RouteObserver<PageRoute>().subscribe(this, route);
    }
  }

  @override
  void didPop() {
    _stopTimer();
  }

  @override
  void didPushNext() {
    _stopTimer();
  }

  void _startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        controller.nextPage(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeIn,
        );
      });
    }
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _stopTimer();
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    List<BannerEntity> banners = [];

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(bottom: (screenHeight * 0.42) - 16),
      height: double.infinity,
      child: BlocBuilder<BannerCubit, BaseState>(
        builder: (context, state) {
          if (state.status.isSuccess && state.entity != null) {
            banners = state.entity;
            _startTimer();
          }
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                controller: controller,
                allowImplicitScrolling: true,
                // onPageChanged: (page){
                //   _timer.cancel();
                // },
                itemBuilder: (_, index) {
                  return Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.bottomLeft,
                    children: [
                      banners.isEmpty
                          ? buildLocalImage()
                          : CachedNetworkImage(
                              imageUrl: banners[index % banners.length].imageUrl,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      buildLocalImage(),
                              errorWidget: (context, url, error) =>
                                  buildLocalImage(),
                            ),
                      Positioned(
                        left: 16,
                        bottom: 56,
                        right: 16,
                        child: Text(
                          banners.isEmpty
                              ? S.of(context).bannerLocal
                              : getLocaleText(
                                  banners[index % banners.length].title),
                          style: AppTextStyle.titleMedium
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        6.height,
                        Text(
                          S.of(context).selectCity,
                          style: AppTextStyle.displayLarge.copyWith(
                            color: AppColors.black.withOpacity(0.5),
                          ),
                        ),
                        BlocBuilder<CityCubit, CityState>(
                          builder: (context, state) {
                            return DropdownButton<String>(
                              value: state.selectCity?.name,
                              isDense: true,
                              icon: SvgPicture.asset(AppAssets.arrowDown),
                              underline: const SizedBox(),
                              style: AppTextStyle.bodyLarge
                                  .copyWith(fontWeight: FontWeight.w600),
                              onChanged: (String? value) {},
                              borderRadius: BorderRadius.circular(16),
                              items: state.entity
                                  ?.map<DropdownMenuItem<String>>(
                                      (CityEntity city) {
                                return DropdownMenuItem<String>(
                                  value: city.name,
                                  child: Text(city.name),
                                  onTap: () {
                                    context.read<CityCubit>().selectCity(city);
                                  },
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                    if (banners.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: SmoothPageIndicator(
                          controller: controller,
                          count: banners.length,
                          effect: WormEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              activeDotColor: AppColors.white,
                              dotColor: AppColors.white
                                  .withOpacity(0.4)), // your preferred effect
                          onDotClicked: (index) {
                            controller.jumpToPage(index);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Image buildLocalImage() {
    return Image.asset(
      AppAssets.banner,
      fit: BoxFit.cover,
    );
  }
}
