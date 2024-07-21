import 'package:equatable/equatable.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();
}

class VideoUrlChanged extends VideoEvent {
  final String videoUrl;
  final String videoTitle;
  final String lectureId;
  final bool isAttachment;

  const VideoUrlChanged(
      this.videoUrl, this.videoTitle, this.lectureId, this.isAttachment);

  @override
  List<Object?> get props => [videoUrl, videoTitle, lectureId];
}
