import 'package:abricoz_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.title, required this.url});
  final String title;
  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}
class _WebViewScreenState extends State<WebViewScreen> {
  late InAppWebViewController webViewController;
  bool isLoading = true;
  late Uri initialUrl;
  bool hasLoadedInitialUrl = false;

  @override
  void initState() {
    super.initState();
    initialUrl = Uri.parse(widget.url); // Set the initial URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: widget.title,
      // ),
      body: Stack(
        children: [
          SafeArea(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri.uri(initialUrl)),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onPermissionRequest: (controller, permission) async {
                return PermissionResponse(
                  resources: permission.resources,
                );
              },
              onLoadStart: (controller, url) {},
              onLoadStop: (controller, url) async {
                hasLoadedInitialUrl = true;
                setState(() {
                  isLoading = false;
                });
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url!;
                if(uri != initialUrl && hasLoadedInitialUrl){
                  context.router.maybePop();
                  return NavigationActionPolicy.CANCEL;
                } else {
                  return NavigationActionPolicy.ALLOW;
                }
              },
            ),
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

