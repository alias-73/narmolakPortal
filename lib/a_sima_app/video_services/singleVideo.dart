
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'video_controller.dart';

class singleVideo extends StatefulWidget {
  late String url;
  singleVideo(this.url);
  @override
  State<StatefulWidget> createState() => singleVideoState();

}

class singleVideoState extends State<singleVideo> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: VideosList(
        videoPlayerController: VideoPlayerController.network(
            widget.url
        ),
        looping: true,
      ),
    );
  }

  Widget txtBox(String title){
    return Positioned(child:
    Text(title),
      top: 80,
      right: 20,);
  }

}