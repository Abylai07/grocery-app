import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/presentation/view/product/widgets/product_bottom_bar.dart';
import 'package:abricoz_app/src/presentation/view/product/widgets/rich_text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_styles/assets.dart';
import '../../../common/app_styles/colors.dart';
import '../../../common/app_styles/text_styles.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../domain/entity/product/product_entity.dart';
import '../../widgets/main_functions.dart';
import '../../widgets/shimmer_widget.dart';

class ProductCardScreen extends StatelessWidget {
  const ProductCardScreen({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height * 0.4;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(AppAssets.favorite),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(AppAssets.close),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ProductBottomBar(product: product),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    product.photoUrl?.isNotEmpty == true
                        ? CachedNetworkImage(
                            height: screenHeight,
                            width: double.infinity,
                            imageUrl: product.photoUrl!,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    ShimmerWidget(
                              width: double.infinity,
                              height: screenHeight,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Container(
                            width: double.infinity,
                            height: screenHeight,
                            color: AppColors.shimmer,
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: RichText(
                        text: TextSpan(
                          text: getLocaleText(product.name),
                          style: AppTextStyle.titleMedium
                              .copyWith(fontWeight: FontWeight.w700),
                          children: [
                            TextSpan(
                              text: '  ${product.weight}',
                              style: AppTextStyle.titleMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.gray),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              buildInfoContainer(context),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).description,
                      style: AppTextStyle.titleSmall
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      getLocaleText(product.description),
                      style: AppTextStyle.bodyMedium.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGray,
                      ),
                    ),
                    const Divider(
                      height: 24,
                      color: AppColors.gray,
                    ),
                    Text(
                      S.of(context).brand,
                      style: AppTextStyle.bodyLarge
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      product.brand?.name ?? '',
                      style: AppTextStyle.bodyMedium.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGray,
                      ),
                    ),
                    const Divider(
                      height: 24,
                      color: AppColors.gray,
                    ),
                    Text(
                      S.of(context).maker,
                      style: AppTextStyle.bodyLarge
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      product.country?.name ?? '',
                      style: AppTextStyle.bodyMedium.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: AppColors.background, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).in100gr,
            style: AppTextStyle.bodyLarge,
          ),
          12.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichTextInfoWidget(
                count: product.calories ?? 0,
                name: S.of(context).calories,
              ),
              RichTextInfoWidget(
                count: product.proteins ?? 0,
                name: S.of(context).proteins,
              ),
              RichTextInfoWidget(
                count: product.fats ?? 0,
                name: S.of(context).fats,
              ),
              RichTextInfoWidget(
                count: product.carbohydrates ?? 0,
                name: S.of(context).carbohydrates,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
