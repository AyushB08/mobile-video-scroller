import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Post1 extends StatefulWidget {
  @override
  _Post1State createState() => _Post1State();
}

class _Post1State extends State<Post1> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video1.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
                Container(
                  child: Text("sd"),
                )
               
              ],
              
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
