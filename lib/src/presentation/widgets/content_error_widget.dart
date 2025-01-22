import 'package:abricoz_app/src/common/enums.dart';
import 'package:abricoz_app/src/presentation/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';

import '../../common/utils/l10n/generated/l10n.dart';

class ContentErrorWidget extends StatelessWidget {
  const ContentErrorWidget({
    this.message,
    this.onTryAgain,
    super.key,
  });

  final String? message;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    final message = this.message;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).somethingError,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (message.isNotNullEmpty) ...[
              const SizedBox(
                height: 16,
              ),
              Text(
                message ?? S.of(context).error_message,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
            if (onTryAgain != null) ...[
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: 260,
                child: CustomMainButton(
                  text: S.of(context).try_again,
                  onTap: onTryAgain,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
