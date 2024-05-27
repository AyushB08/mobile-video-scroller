import 'package:flutter/material.dart';
import 'package:video_scroller/widgets/video_screen.dart';

class Home extends StatelessWidget {
  final controller = PageController();
  final List<String> videoData = [
    "assets/video1.mp4",
    "assets/video2.mp4",
    "assets/video3.mp4",
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> videoWidgets = [];

    for (String videoFilePath in videoData) {
      videoWidgets.add(VideoPlayerWidget(videoFilePath: videoFilePath));
    }

    return Scaffold(
      body: PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        children: videoWidgets,
      ),
    );
  }
}
