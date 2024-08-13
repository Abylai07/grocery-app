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
import '../../../widgets/shimmer_widget.dart';
import '../bloc/banner_cubit.dart';

class SliderBodyWidget extends StatelessWidget {
  const SliderBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 1, keepPage: true);
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(bottom: (screenHeight * 0.42) - 16),
      height: double.infinity,
      child: BlocBuilder<BannerCubit, BaseState>(
        builder: (context, state) {
          if (state.status.isSuccess) {
            List<BannerEntity>? banners = state.entity;
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  controller: controller,
                  allowImplicitScrolling: true,
                  itemBuilder: (_, index) {
                    return CachedNetworkImage(
                      imageUrl: getLocaleText(banners?[index % banners.length].imageUrl),
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                      const SizedBox(),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
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
                            S.of(context).selectAddress,
                            style: AppTextStyle.displayLarge.copyWith(
                              color: AppColors.black.withOpacity(0.5),
                            ),
                          ),
                          BlocBuilder<CityCubit, CityState>(
                            builder: (context, state) {
                              return DropdownButton<String>(
                                value: state.selectCity?.name,
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
                                      context
                                          .read<CityCubit>()
                                          .selectCity(city);
                                    },
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: SmoothPageIndicator(
                          controller: controller,
                          count: banners?.length ?? 0,
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
          } else {
            return Center(
              child: Text(
                'Abricoz',
                style: AppTextStyle.titleLarge.copyWith(
                    fontWeight: FontWeight.w700, color: AppColors.shimmer),
              ),
            );
          }
        },
      ),
    );
  }
}
