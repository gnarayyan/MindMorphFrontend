import 'package:flutter/material.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import 'package:mindmorph/widgets/snackbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../constants/urls.dart';

class PaymentViaWeb extends StatelessWidget {
  const PaymentViaWeb(
      {super.key,
      required this.userId,
      required this.courseId,
      required this.totalAmount,
      required this.cartId});
  final int userId;
  final int courseId;
  final int totalAmount;
  final int cartId;

  // ..loadRequest(Uri.parse('http://$NODE_SERVER/certificate'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: SafeArea(
          child: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setBackgroundColor(const Color(0x00000000))
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {
                      const MindMorphLoadingIndicator();
                    },
                    onPageStarted: (String url) {
                      print('Changed to new Page1 => $url');
                    },
                    onPageFinished: (String url) {
                      print('Changed to new Page2 => $url');
                    },
                    onWebResourceError: (WebResourceError error) {},
                    onNavigationRequest: (NavigationRequest request) {
                      if (request.url.startsWith(
                          'http://$NODE_SERVER/payment/esewa/success')) {
                        mindMorphSnackBar(
                            context: context, message: 'Payment Success');
                        context.go('/');
                      } else if (request.url.startsWith(
                          'http://$NODE_SERVER/payment/esewa/failure')) {
                        mindMorphSnackBar(
                            context: context,
                            message: 'Payment Failed',
                            isError: true);
                        context.go('/');
                      }

                      return NavigationDecision.navigate;
                    },
                  ),
                )
                ..loadRequest(Uri.parse(
                    'http://$NODE_SERVER/payment/esewa?userId=$userId&totalAmount=$totalAmount&courseId=$courseId&cartId=$cartId')))),
    );
  }
}
