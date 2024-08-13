import 'package:abricoz_app/src/common/app_styles/text_styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/utils/app_router/app_router.dart';
import '../../../../domain/entity/product/category_entity.dart';
import '../../../widgets/main_functions.dart';
import '../../../widgets/shimmer_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.category,
  });

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        context.router.push(SubCategoryRoute(category: category));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getLocaleText(category.name),
              style: AppTextStyle.displayLarge
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            if (category.photoUrl != null)
              Center(child: SvgPicture.network(category.photoUrl!))
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
            height: 120,
          ),
          ShimmerWidget(
            width: width,
            height: 120,
          ),
          ShimmerWidget(
            width: width,
            height: 120,
          ),
        ],
      ),
    );
  }
}
