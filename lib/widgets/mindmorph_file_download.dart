import 'package:flutter_file_downloader/flutter_file_downloader.dart';

Future<void> mindmorphFileDownloader({required String url}) async {
  await FileDownloader.downloadFile(
    url: url,
    // name: 'certificate.pdf',
    downloadDestination: DownloadDestinations.publicDownloads,
    notificationType: NotificationType.all,
  );
}
