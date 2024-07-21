import 'package:flutter/material.dart';
import './mindmorph_file_download.dart';

class MindMorphDownloadFileButton extends StatefulWidget {
  const MindMorphDownloadFileButton({super.key, required this.pdfUrl});
  final String pdfUrl;

  @override
  State<MindMorphDownloadFileButton> createState() =>
      _MindMorphDownloadFileButtonState();
}

class _MindMorphDownloadFileButtonState
    extends State<MindMorphDownloadFileButton> {
  bool isSavedToDownloadFolder = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await mindmorphFileDownloader(url: widget.pdfUrl);
        setState(() {
          isSavedToDownloadFolder = true;
        });
      },
      icon: Icon(isSavedToDownloadFolder
          ? Icons.download_done_outlined
          : Icons.download),
    );
  }
}
