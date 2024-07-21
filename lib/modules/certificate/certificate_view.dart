import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:mindmorph/constants/color.dart';
import 'package:mindmorph/constants/urls.dart';

class CertificateScreen extends StatelessWidget {
  const CertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        color: titlecolor,
        onPressed: () async {
          //           final result = await FilePicker.platform.saveFile(dialogTitle: 'Choose a folder to Save Certificate',allowedExtensions: ['pdf'],fileName: 'Certificate.pdf',)
          // if (result != null) {

          FileDownloader.downloadFile(
              url: 'http://$COURSE_SERVER/media/pdf.pdf',
              name: 'certificate.pdf',
              downloadDestination: DownloadDestinations.publicDownloads,
              notificationType: NotificationType.all);
        },

        // () => context.push('/payment-via-web'),
        icon: const Icon(Icons.download_sharp),
      ),
    );
  }
}
