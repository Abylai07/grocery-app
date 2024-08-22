import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../domain/entity/product/sub_category_entity.dart';
import '../../../widgets/main_functions.dart';

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
        FocusScope.of(context).unfocus();
        context.router.push(ProductRoute(subCategory: subCategory));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.backgroundBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getLocaleText(subCategory.name),
              style: AppTextStyle.displayLarge
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            subCategory.photoUrl != null
                ? SvgPicture.network(subCategory.photoUrl!)
                : const SizedBox()
            // CachedNetworkImage(
            //   imageUrl: ,
            //   fit: BoxFit.fitWidth,
            //   progressIndicatorBuilder:
            //       (context, url, downloadProgress) =>
            //   const ShimmerWidget(
            //     width: double.infinity,
            //     height: 60,
            //   ),
            //   errorWidget: (context, url, error) =>
            //   const Icon(Icons.error),
            // )
          ],
        ),
      ),
    );
  }
}
