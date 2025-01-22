import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/domain/entity/order/check_card_entity.dart';
import 'package:abricoz_app/src/presentation/widgets/main_functions.dart';
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
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).cart_update,
                style: AppTextStyle.titleSmall,
                textAlign: TextAlign.center,
              ),
              if (entity.inactivatedProducts.isNotNullEmpty) ...[
                Text(
                  S.of(context).inactive_products,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                for (var item in entity.inactivatedProducts)
                  Text(
                    "- ${getLocaleText(item.name)}",
                    style: const TextStyle(color: AppColors.errorRedColor),
                    maxLines: 2,
                  ),
              ],
              if (removedProducts.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  S.of(context).removed_products,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                for (var item in entity.shortagedProducts)
                  Text(
                    "- ${getLocaleText(item.name)} → ${S.of(context).remaining} ${item.availableQuantity}",
                    style: const TextStyle(color: Colors.red),
                    maxLines: 2,
                  ),
              ],
              if (changedProducts.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  S.of(context).changed_quantity,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                for (var item in entity.shortagedProducts)
                  Text(
                    "- ${getLocaleText(item.name)}: ${item.requestedQuantity} → ${item.availableQuantity}",
                    maxLines: 2,
                  ),
              ],
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: onYesTap,
            child: Container(
              height: 40,
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
