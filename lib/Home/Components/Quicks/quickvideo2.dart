import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Quickvideo2 extends StatefulWidget {
  Quickvideo2() : super();

  final String title = "Video Demo";

  @override
  State<Quickvideo2> createState() => _Quickvideo2State();
}

class _Quickvideo2State extends State<Quickvideo2> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _showStatus = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/newsvideos/quick2.mp4"); // video here
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.setLooping(true);
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _showStatusBox('Paused');
      } else {
        _controller.play();
        _showStatusBox('Playing');
      }
    });
  }

  void _showStatusBox(String status) {
    setState(() {
      _showStatus = true;
    });
    Timer(Duration(seconds: 3), () {
      setState(() {
        _showStatus = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: _togglePlayPause,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                if (_showStatus)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      color: Colors.black54,
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        _controller.value.isPlaying ? CupertinoIcons.play : CupertinoIcons.pause,
                        color: Colors.white,size: 40,),
                    ),
                  ),

              ]
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}