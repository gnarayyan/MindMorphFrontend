import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:mindmorph/widgets/snackbar.dart';

import '../../data/repositories/lecture_progress.dart';

class XYZPlayer extends StatefulWidget {
  const XYZPlayer({super.key, required this.videoUrl, this.lectureId = ''});
  final String videoUrl;

  final String lectureId;

  @override
  State<XYZPlayer> createState() => _XYZPlayerState();
}

class _XYZPlayerState extends State<XYZPlayer> {
  late BetterPlayerController _betterPlayerController;
  final _configuration = const BetterPlayerConfiguration(
    autoDetectFullscreenDeviceOrientation: true,
    fit: BoxFit.contain,
    autoPlay: true,
    autoDispose: true,
  );

  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    _setupVideoPlayer(widget.videoUrl);
  }

  @override
  void didUpdateWidget(XYZPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _betterPlayerController.dispose();
      _setupVideoPlayer(widget.videoUrl);
    }
  }

  void _setupVideoPlayer(String videoUrl) {
    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      videoUrl,
    );
    _betterPlayerController = BetterPlayerController(
      _configuration,
      betterPlayerDataSource: dataSource,
    );

    // Get Lecture Playing Status

    // Add video complete event
    _betterPlayerController.addEventsListener((event) async {
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        if (widget.lectureId == '') return;
        final lectureData =
            await LectureProgressRepository.startLecture(widget.lectureId);
        if (context.mounted) {
          mindMorphSnackBar(context: context, message: lectureData.message);
        }
        if (lectureData.isResume) {
          // Update completion status
          setState(() {
            isCompleted = lectureData.progress!.completed;
          });

          final duration = isCompleted
              ? ['00', '00', '00']
              : lectureData.progress!.duration.split(':');

          int hours = int.parse(duration[0]);
          int minutes = int.parse(duration[1]);
          int seconds = int.parse(duration[2]);

          final moment =
              Duration(hours: hours, minutes: minutes, seconds: seconds);
          _betterPlayerController.seekTo(moment);
        }
      }

      if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
        if (widget.lectureId == '') return;
        //TODO: mark as completed
        final result = await LectureProgressRepository.saveProgress(
          {"lectureId": widget.lectureId, "completed": true},
        );

        setState(() {
          isCompleted = true;
        });

        if (context.mounted) {
          mindMorphSnackBar(
              context: context,
              message: result.message,
              isError: !result.isSuccess);
        }
      }
      // if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
      //   print('Video is Playing ');
      //   // _betterPlayerController.videoPlayerController!.position;
      // }
      // if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
      //   print('Video is Paused ');
      //   Duration? duration =
      //       await _betterPlayerController.videoPlayerController!.position;

      //   print('Current Duration: ${duration ?? 0.0}');
      // }
    });
  }

  void _saveLectureProgressBeforeDispose() async {
    if (widget.lectureId != '') {
      Duration? duration =
          await _betterPlayerController.videoPlayerController!.position;

      // final result =
      await LectureProgressRepository.saveProgress(
        {
          "lectureId": widget.lectureId,
          "duration": '0${duration.toString().split('.')[0]}',
        },
      );

      // print('isSuccess: ${result.isSuccess}    Message: ${result.message} ');

      // if (context.mounted) {
      //   mindMorphSnackBar(
      //       context: context,
      //       message: result.message,
      //       isError: !result.isSuccess);
      // }

      //completed saving
    }
  }

  @override
  void dispose() {
    //TODO: Save progress
    if (!isCompleted) _saveLectureProgressBeforeDispose();
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: _betterPlayerController,
    );
  }
}
