import 'package:abricoz_app/src/common/utils/app_router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../common/app_styles/text_styles.dart';
import '../../../common/utils/l10n/generated/l10n.dart';

nonAuthorizeModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Text(
                  S.of(context).nonAuthorizedText,
                  style: AppTextStyle.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        await context.router.maybePop();
                        context.router.push(const SignInRoute());
                      },
                      child: Text(S.of(context).login)),
                ),
                const SizedBox(height: 24),
                SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => context.router.maybePop(),
                      child: Text(S.of(context).close,
                          style: AppTextStyle.bodyLarge),
                    )),
                const SafeArea(
                  child: SizedBox(
                    height: 16,
                  ),
                )
              ],
            ),
          ),
        );
      });
}
