import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_event.dart';
import 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc(String initialUrl, String initialVideoTitle)
      : super(VideoState(
            videoUrl: initialUrl,
            videoTitle: initialVideoTitle,
            lectureId: '',
            isAttachment: false)) {
    on<VideoUrlChanged>((event, emit) async {
      emit(VideoState(
          videoUrl: event.videoUrl,
          videoTitle: event.videoTitle,
          lectureId: event.lectureId,
          isAttachment: event.isAttachment));
    });
  }
}
