// import 'package:flutter/material.dart';
// import 'package:mindmorph/widgets/loading_indicator.dart';
// import 'package:mindmorph/widgets/snackbar.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:go_router/go_router.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// import '../../../../constants/urls.dart';

// class CertificateWebView extends StatelessWidget {
//   const CertificateWebView({
//     super.key,
//     required this.url,
//     required this.coursetitle,
//   });
//   final String url;
//   final String coursetitle;
//   // ..loadRequest(Uri.parse('http://$NODE_SERVER/certificate'));

//   @override
//   Widget build(BuildContext context) {
//     /// desktop User Agent
//     // const desktopUserAgent =
//     //     "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0";

//     const javaScriptToShowDesktopSite =
//         "document.querySelector('meta[name=\"viewport\"]').setAttribute('content', 'width=1024px, initial-scale=' + (document.documentElement.clientWidth / 1024));";

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(coursetitle),
//         actions: [
//           IconButton(
//             onPressed: () {
//               //TODO: Lunch Download
//             },
//             icon: const Icon(Icons.download_sharp),
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(top: context.screenHeight * .2),
//           child: WebViewWidget(
//             controller: WebViewController()
//               ..setJavaScriptMode(JavaScriptMode.unrestricted)
//               ..setBackgroundColor(const Color(0x00000000))
//               ..enableZoom(true)
//               ..runJavaScript(javaScriptToShowDesktopSite)
//               // ..setUserAgent(desktopUserAgent)
//               ..setNavigationDelegate(
//                 NavigationDelegate(
//                   onProgress: (int progress) {
//                     const MindMorphLoadingIndicator();
//                   },
//                   onWebResourceError: (WebResourceError error) {},
//                   onNavigationRequest: (NavigationRequest request) {
//                     if (request.url.startsWith('http://google.com')) {
//                       mindMorphSnackBar(
//                           context: context, message: 'Payment Success');
//                       context.go('/');
//                     }

//                     return NavigationDecision.navigate;
//                   },
//                 ),
//               )
//               ..loadRequest(
//                 Uri.parse('http://$NODE_SERVER/$url'),
//               ),
//           ),
//         ),
//       ),
//     );
//   }
// }
