import 'package:grocery_app/src/common/utils/app_router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../domain/entity/product/sub_category_entity.dart';
import '../../../widgets/main_functions.dart';
import '../../../widgets/shimmer_widget.dart';

class SubCategoryWidget extends StatelessWidget {
  const SubCategoryWidget({
    super.key,
    required this.subCategory,
  });

  final SubCategoryEntity subCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(ProductRoute(subCategory: subCategory));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (subCategory.photoUrl != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: subCategory.photoUrl?.contains('.svg') == true
                    ? SvgPicture.network(
                        subCategory.photoUrl!,
                        height: 80,
                      )
                    : CachedNetworkImage(
                        imageUrl: subCategory.photoUrl!,
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
                getLocaleText(subCategory.name),
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
