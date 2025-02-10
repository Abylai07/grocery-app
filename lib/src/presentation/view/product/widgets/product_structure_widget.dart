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
    if ((product.calories ?? 0) <= 0 &&
        (product.proteins ?? 0) <= 0 &&
        (product.fats ?? 0) <= 0 &&
        (product.carbohydrates ?? 0) <= 0) {
      return const SizedBox
          .shrink(); // Don't show the widget if all values are null or ≤ 0
    }

    List<Widget> nutrientWidgets = [];

    if ((product.calories ?? 0) > 0) {
      nutrientWidgets.add(RichTextInfoWidget(
        count: product.calories!,
        name: S.of(context).calories,
      ));
    }

    if ((product.proteins ?? 0) > 0) {
      nutrientWidgets.add(RichTextInfoWidget(
        count: product.proteins!,
        name: S.of(context).proteins,
      ));
    }

    if ((product.fats ?? 0) > 0) {
      nutrientWidgets.add(RichTextInfoWidget(
        count: product.fats!,
        name: S.of(context).fats,
      ));
    }

    if ((product.carbohydrates ?? 0) > 0) {
      nutrientWidgets.add(RichTextInfoWidget(
        count: product.carbohydrates!,
        name: S.of(context).carbohydrates,
      ));
    }
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).in100gr,
            style: AppTextStyle.bodyLarge,
          ),
          12.height,
          SizedBox(
            width: nutrientWidgets.length > 2 ? width : width / 2.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: nutrientWidgets, // Show only available nutrients
            ),
          ),
        ],
      ),
    );
  }
}
