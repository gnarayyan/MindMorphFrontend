import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:mindmorph/widgets/download_file_button.dart';

class PDFViewScreen extends StatefulWidget {
  const PDFViewScreen(
      {super.key, required this.pdfUrl, required this.appBarTitle});
  final String pdfUrl;
  final String appBarTitle;

  @override
  State<PDFViewScreen> createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  int currentPageNumber = 0;
  int totalPageNumber = 0;
  String pdfFilePath = '';
  bool isFileDownloaded = false;

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  Future<void> _downloadPDF() async {
    final file = await FileDownloader.downloadFile(
      url: widget.pdfUrl,
      // name: 'certificate.pdf',
      downloadDestination: DownloadDestinations.appFiles,
      // notificationType: NotificationType.all,
    );

    setState(() {
      pdfFilePath = file!.path;
      isFileDownloaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _downloadPDF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        actions: [
          Text('$currentPageNumber / $totalPageNumber'),
          MindMorphDownloadFileButton(pdfUrl: widget.pdfUrl)
        ],
      ),
      body: !isFileDownloaded
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : PDFView(
              filePath: pdfFilePath,
              enableSwipe: true,
              swipeHorizontal: true,
              fitPolicy: FitPolicy.WIDTH,
              autoSpacing: false,
              pageFling: false,

              // onRender: (_pages) {

              // },
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onPageChanged: (int? page, int? total) {
                setState(() {
                  currentPageNumber = page ?? -1;
                  totalPageNumber = total ?? -2;
                });
              },
            ),
    );
  }
}
