import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoWidget extends StatefulWidget {
  final String videoLink;
  final bool isLocalFilePath;

  @override
  _VideoWidgetState createState() => _VideoWidgetState();

  const VideoWidget(this.videoLink, [this.isLocalFilePath = false]);

  GetVideoController() {
    return _VideoWidgetState()._controller;
  }
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (!widget.isLocalFilePath) {
      _controller = VideoPlayerController.network(widget.videoLink);
    } else {
      _controller = VideoPlayerController.file(File(widget.videoLink));
    }

    _controller
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

        setState(() {});
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

/*
floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),*/
