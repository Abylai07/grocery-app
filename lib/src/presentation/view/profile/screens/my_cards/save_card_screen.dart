import 'package:grocery_app/src/common/utils/app_router/app_router.dart';
import 'package:grocery_app/src/common/utils/shared_preference.dart';
import 'package:grocery_app/src/presentation/view/basket/bloc/basket_bloc/basket_bloc.dart';
import 'package:grocery_app/src/presentation/widgets/show_error_snackbar.dart';
import 'package:grocery_app/src/presentation/widgets/snack_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../common/app_styles/assets.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../widgets/custom_app_bar.dart';

@RoutePage()
class SaveCardScreen extends StatefulWidget {
  const SaveCardScreen({
    super.key,
  });

  @override
  State<SaveCardScreen> createState() => _SaveCardScreenState();
}

class _SaveCardScreenState extends State<SaveCardScreen> {
  late InAppWebViewController webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    String? userId = SharedPrefs().getId();

    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).saveCard,
        onBackPressed: () => context.router.maybePop(),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
                url: WebUri.uri(Uri.parse(
              'https://abricoz.kz/payment?user_id=$userId',
            ))),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onPermissionRequest: (InAppWebViewController controller,
                PermissionRequest permission) async {
              return PermissionResponse(
                resources: permission.resources,
              );
            },
            onLoadStart: (controller, url) {
              if (url.toString().contains('https://abricoz.kz/success')) {
                AutoRouter.of(context).maybePop();
                showSnackBar(context, S.of(context).saveCardSuccess);
              } else if (url.toString().contains('https://abricoz.kz/failure')) {
                AutoRouter.of(context).maybePop();
                showSnackBar(
                  context,
                  S.of(context).errorPlsAgain,
                  image: AppAssets.cancel,
                );
              }
            },
            onLoadStop: (controller, url) async {
              setState(() {
                isLoading = false;
              });
              if(userId == null) {
                showSnackBar(context, 'Ваш идентификатор отсутствует, пожалуйста, снова войдите в свою учетную запись', image: AppAssets.cancel);
                context.router.replace(const SignInRoute());
              }
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url!;
              return NavigationActionPolicy.ALLOW;
            },
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(), // Show loading indicator
            ),
        ],
      ),
    );
  }
}
