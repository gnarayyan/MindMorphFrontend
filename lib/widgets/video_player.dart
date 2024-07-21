import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class MindMorphVideoPlayer extends StatefulWidget {
  const MindMorphVideoPlayer({super.key, required this.videoUrl});
  final String videoUrl;
  // final VideoPlayerData video;

  @override
  State<MindMorphVideoPlayer> createState() => _MindMorphVideoPlayerState();
}

class _MindMorphVideoPlayerState extends State<MindMorphVideoPlayer> {
  late BetterPlayerController _betterPlayerController;
  final _configuration = const BetterPlayerConfiguration(
    autoDetectFullscreenDeviceOrientation: true,
    fit: BoxFit.contain,
    // aspectRatio: 16 / 9,
    autoPlay: true,
    autoDispose: true,
  );

  @override
  void initState() {
    super.initState();

    final dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, widget.videoUrl
        // widget.video.url,
        // notificationConfiguration: BetterPlayerNotificationConfiguration(
        //   showNotification: true,
        //   title: widget.video.title,
        //   author: widget.video.author,
        //   imageUrl: widget.video.courseThumbailUrl,
        //   activityName: "MainActivity",
        // ),
        );
    _betterPlayerController = BetterPlayerController(
      _configuration,
      betterPlayerDataSource: dataSource,
    );
  }

  @override
  void dispose() {
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
