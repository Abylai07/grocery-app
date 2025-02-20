import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/src/panel.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/utils/app_router/app_router.dart';
import '../../../../domain/entity/product/category_entity.dart';
import '../../../widgets/main_functions.dart';
import '../../../widgets/shimmer_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.category,
    required this.controller,
  });

  final CategoryEntity category;
  final PanelController controller;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        if (controller.isAttached && !controller.isPanelOpen) {
          controller.open();
        }
        AutoRouter.of(context).push(SubCategoryRoute(category: category));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (category.mobileUrl != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: category.mobileUrl?.contains('.svg') == true
                    ? SvgPicture.network(
                        category.mobileUrl!,
                        height: 80,
                      )
                    : CachedNetworkImage(
                        imageUrl: category.mobileUrl!,
                        fit: BoxFit.contain,
                        height: 80,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                const ShimmerWidget(
                          width: double.infinity,
                          height: 80,
                        ),
                        errorWidget: (context, url, error) => const SizedBox(),
                      ),
              ),
            Positioned(
              top: 8,
              right: 8,
              left: 8,
              child: Text(
                getLocaleText(category.name),
                style: AppTextStyle.displayLarge
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryLoadingWidget extends StatelessWidget {
  const CategoryLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = (screenSize.width - 48) / 3;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShimmerWidget(
            width: width,
            height: 130,
          ),
          ShimmerWidget(
            width: width,
            height: 130,
          ),
          ShimmerWidget(
            width: width,
            height: 130,
          ),
        ],
      ),
    );
  }
}
