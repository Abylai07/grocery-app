import 'package:grocery_app/src/common/enums.dart';
import 'package:grocery_app/src/domain/entity/order/check_card_entity.dart';
import 'package:grocery_app/src/presentation/widgets/main_functions.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';

void productChangedAlert(BuildContext context,
    {required CheckCardEntity entity, Function()? onYesTap}) {
  final removedProducts = entity.shortagedProducts
      .where((item) => item.availableQuantity == 0)
      .toList();
  final changedProducts = entity.shortagedProducts
      .where((item) =>
          item.availableQuantity > 0 &&
          item.availableQuantity != item.requestedQuantity)
      .toList();

  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.white,
        contentPadding:
            const EdgeInsets.only(top: 24, bottom: 14, left: 16, right: 16),
        actionsPadding: const EdgeInsets.all(16),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  S.of(context).cart_update,
                  style: AppTextStyle.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              if (entity.inactivatedProducts.isNotNullEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    S.of(context).inactive_products,
                    style: AppTextStyle.bodyLarge
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                for (var item in entity.inactivatedProducts)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 4),
                    child: Text(
                      "- ${getLocaleText(item.name)}",
                      style: AppTextStyle.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                const SizedBox(height: 4),
              ],
              // if (removedProducts.isNotEmpty || changedProducts.isNotEmpty) ...[
              //   Text(
              //     S.of(context).insufficient_stock,
              //     style: AppTextStyle.bodyLarge
              //         .copyWith(fontWeight: FontWeight.bold),
              //   ),
              //   const SizedBox(height: 8),
              // ],
              if (removedProducts.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    S.of(context).removed_products,
                    style: AppTextStyle.bodyLarge
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                for (var item in removedProducts)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 4),
                    child: Text(
                      "- ${getLocaleText(item.name)} → ${S.of(context).remaining} ${item.availableQuantity}",
                      style: AppTextStyle.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
                const SizedBox(height: 4),
              ],
              if (changedProducts.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    S.of(context).changed_quantity,
                    style: AppTextStyle.bodyLarge
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                for (var item in changedProducts)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 4),
                    child: Text(
                      "- ${getLocaleText(item.name)}: ${item.requestedQuantity} → ${item.availableQuantity}",
                      style: AppTextStyle.bodyMedium,
                      maxLines: 2,
                    ),
                  ),
              ],
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: onYesTap,
            child: Container(
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.main,
              ),
              child: Text(
                S.of(context).confirm,
                style: AppTextStyle.bodyLarge.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      );
    },
  );
}
