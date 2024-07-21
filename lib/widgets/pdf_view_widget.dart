// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter_file_downloader/flutter_file_downloader.dart';
// import 'package:mindmorph/widgets/download_file_button.dart';

// import 'pdf_view_screen.dart';

// class PDFViewWidget extends StatefulWidget {
//   const PDFViewWidget(
//       {super.key, required this.pdfUrl, required this.lectureName});
//   final String pdfUrl;
//   final String lectureName;

//   @override
//   State<PDFViewWidget> createState() => _PDFViewWidgetState();
// }

// class _PDFViewWidgetState extends State<PDFViewWidget> {
//   int currentPageNumber = 0;
//   int totalPageNumber = 0;
//   String pdfFilePath = '';
//   bool isFileDownloaded = false;

//   final Completer<PDFViewController> _controller =
//       Completer<PDFViewController>();

//   Future<String> _downloadPDF() async {
//     final file = await FileDownloader.downloadFile(
//       url: widget.pdfUrl,
//       // name: 'certificate.pdf',
//       downloadDestination: DownloadDestinations.appFiles,
//       // notificationType: NotificationType.all,
//     );

//     return file!.path;

//     // setState(() {
//     //   pdfFilePath = file!.path;
//     //   isFileDownloaded = true;
//     // });
//   }

//   @override
//   void didChangeDependencies() async {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     final pdfPath = await _downloadPDF();
//     setState(() {
//       pdfFilePath = pdfPath;
//       isFileDownloaded = true;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // height: context.screenHeight * 0.7,
//       // width: context.screenWidth * 0.7,
//       child:
//           // !isFileDownloaded
//           //     ? const Center(
//           //         child: CircularProgressIndicator(
//           //           color: Colors.green,
//           //         ),
//           //       )
//           //     :
//           Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                           builder: (context) => PDFViewScreen(
//                                 appBarTitle: widget.lectureName,
//                                 pdfUrl: widget.pdfUrl,
//                               )),
//                     );
//                   },
//                   icon: const Icon(Icons.fullscreen)),
//               Text('$currentPageNumber / $totalPageNumber'),
//               MindMorphDownloadFileButton(pdfUrl: widget.pdfUrl)
//             ],
//           ),
//           Container(
//             width: double.infinity,
//             child: PDFView(
//               filePath: pdfFilePath,
//               enableSwipe: true,
//               swipeHorizontal: true,
//               fitPolicy: FitPolicy.WIDTH,
//               autoSpacing: false,
//               pageFling: false,

//               // onRender: (_pages) {

//               // },
//               onError: (error) {
//                 print(error.toString());
//               },
//               onPageError: (page, error) {
//                 print('$page: ${error.toString()}');
//               },
//               onViewCreated: (PDFViewController pdfViewController) {
//                 _controller.complete(pdfViewController);
//               },
//               onPageChanged: (int? page, int? total) {
//                 setState(() {
//                   currentPageNumber = page ?? -1;
//                   totalPageNumber = total ?? -2;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
