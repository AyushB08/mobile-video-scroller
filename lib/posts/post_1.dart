import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Post1 extends StatefulWidget {
  @override
  Post1State createState() => Post1State();
}

class Post1State extends State<Post1> {
  late VideoPlayerController controller;
  int likeCount = 123;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset('assets/video1.mp4')
      ..initialize().then((_) {
        setState(() {
          controller.play();
          controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Comments',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text('Comment $index'),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.thumb_up, size: 20), // Adjust size as needed
                                onPressed: () {
                                  // Handle like button press
                                },
                              ),
                              Text('0'), // Replace '0' with actual like count
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),


              Padding(
                padding: EdgeInsets.only(left: 50, top: 0, right: 50, bottom: 30),

                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Add a comment',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    
                  ),
                ),
              ),
              
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.value.isInitialized
          ? Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.size.width,
                    height: controller.value.size.height,
                    child: VideoPlayer(controller),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  right: 20,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.thumb_up, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                likeCount++;
                              });
                            },
                          ),
                          Text(
                            '$likeCount',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 10), // Add spacing between the icons
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.comment, color: Colors.white),
                            onPressed: () {
                              showCommentsBottomSheet(context);
                            },
                          ),
                          Text(
                            '45',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 10), // Add spacing between the icons
                      IconButton(
                        icon: Icon(Icons.share, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
