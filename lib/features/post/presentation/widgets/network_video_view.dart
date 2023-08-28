import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class NetworkVideoView extends StatefulWidget {
  const NetworkVideoView({
    super.key,
    required this.fileUrl,
  });

  final String fileUrl;

  @override
  State<NetworkVideoView> createState() => _NetworkVideoViewState();
}

class _NetworkVideoViewState extends State<NetworkVideoView> {
  late final CachedVideoPlayerController _videoController;

  // local fields
  bool isPlaying = false;

  @override
  void initState() {
    _videoController = CachedVideoPlayerController.network(widget.fileUrl)
      ..initialize().then((value) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: Stack(
        children: [
          CachedVideoPlayer(
            _videoController,
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                if (isPlaying) {
                  _videoController.pause();
                } else {
                  _videoController.play();
                }
                isPlaying = !isPlaying;
                setState(() {});
              },
              icon: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                size: 50,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}