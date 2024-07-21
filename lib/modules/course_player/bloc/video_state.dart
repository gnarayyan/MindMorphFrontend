import 'package:equatable/equatable.dart';

class VideoState extends Equatable {
  final String videoUrl;
  final String videoTitle;
  final String lectureId;
  final bool isAttachment;

  const VideoState(
      {required this.isAttachment,
      required this.videoTitle,
      required this.videoUrl,
      required this.lectureId});

  @override
  List<Object?> get props => [videoUrl, videoTitle, lectureId];
}
