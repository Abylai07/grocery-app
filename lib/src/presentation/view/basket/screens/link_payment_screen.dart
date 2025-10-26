import 'package:grocery_app/src/common/utils/app_router/app_router.dart';
import 'package:grocery_app/src/presentation/view/basket/bloc/basket_bloc/basket_bloc.dart';
import 'package:grocery_app/src/presentation/widgets/show_error_snackbar.dart';
import 'package:grocery_app/src/presentation/widgets/snack_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../common/app_styles/assets.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../widgets/custom_app_bar.dart';

@RoutePage()
class LinkPaymentScreen extends StatefulWidget {
  final String type;
  final String url;
  const LinkPaymentScreen({
    super.key,
    required this.url,
    required this.type,
  });

  @override
  State<LinkPaymentScreen> createState() => _LinkPaymentScreenState();
}

class _LinkPaymentScreenState extends State<LinkPaymentScreen> {
  late InAppWebViewController webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).payment,
        onBackPressed: () => context.router.maybePop(),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest:
                URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
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
              if (url.toString().contains('abricos-success-pay.kz')) {
                BlocProvider.of<BasketBloc>(context)
                    .add(const DeleteAllBasket());
                AutoRouter.of(context).maybePop();
                showSnackBar(context, S.of(context).thanksForOrder);
              } else if (url.toString().contains('abricos-failure-pay.kz')) {
                AutoRouter.of(context).maybePop();
                showSnackBar(
                  context,
                  S.of(context).payFailed,
                  image: AppAssets.cancel,
                );
              }
            },
            onLoadStop: (controller, url) async {
              setState(() {
                isLoading = false;
              });
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
