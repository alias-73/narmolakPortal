import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideosList extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  const VideosList(
      {Key? key, required this.videoPlayerController, required this.looping})
      : super(key: key);

  @override
  _VideosListState createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  late ChewieController videosController;

  @override
  void initState() {
    super.initState();

    videosController = ChewieController(

      showOptions: true,
      allowFullScreen: true,
      fullScreenByDefault: true,
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(child: progressBar()
        );
      },
    );
  }

  Widget progressBar() {
    return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(

        controller: videosController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    // widget.videoPlayerController.dispose();
    videosController.pause();

    videosController.dispose();
  }
}