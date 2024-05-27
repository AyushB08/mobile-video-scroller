import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoFilePath;

  const VideoPlayerWidget({Key? key, required this.videoFilePath}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeController() async {
    _controller = VideoPlayerController.asset(widget.videoFilePath);
    await _controller.initialize();
    setState(() {
      _controller.play();
      _controller.setLooping(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
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
              Positioned(
                bottom: 40,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.video,
                      allowMultiple: false,
                    );

                    if (result != null) {
                      PlatformFile? file = result.files.first;
                      if (file != null && file.path != null) {
                       
                        File newFile = File(file.path!);
                        String newVideoPath = 'assets/${file.name}';
                        await newFile.copy(newVideoPath);

                       
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoPlayerWidget(videoFilePath: newVideoPath),
                        ));
                      } else {
                        
                      }
                    } else {
                     
                    }
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          )
        : Center(child: CircularProgressIndicator());
  }
}
