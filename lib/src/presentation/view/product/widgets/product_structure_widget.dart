import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/presentation/view/product/widgets/rich_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/product/product_entity.dart';

class ProductStructureWidget extends StatelessWidget {
  const ProductStructureWidget({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return product.calories == null && product.proteins == null
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10)),
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
