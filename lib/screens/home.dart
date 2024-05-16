import "package:flutter/material.dart";
import "package:video_scroller/posts/post_1.dart";
import "package:video_scroller/posts/post_2.dart";

class Home extends StatelessWidget {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: PageView ( 
        controller: controller,
        scrollDirection: Axis.vertical,
        children: [
          Post1(),
          Post2(),
        ]
      )
    );
  }
}