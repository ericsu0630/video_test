import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  static const id = 'practice.dart';
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _videoMainController;

  @override
  void initState() {
    //main video
    _videoMainController =
        VideoPlayerController.networkUrl(Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
    _videoMainController.setLooping(true);
    _videoMainController.setVolume(0.0);
    _videoMainController.play();
    super.initState();
  }

  @override
  void dispose() {
    _videoMainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double containerMargin = 16.0;
    double aspectRatio = _videoMainController.value.aspectRatio;
    double dynamicWidth = MediaQuery.of(context).size.width - containerMargin * 2;
    double dynamicHeight = dynamicWidth / aspectRatio;

    return Scaffold(
      appBar: AppBar(
        title: const Text('V I D E O'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      backgroundColor: Colors.deepPurpleAccent[100],
      body: Container(
        width: dynamicWidth,
        height: dynamicHeight,
        margin: EdgeInsets.all(containerMargin),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.yellow, width: 4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), //account for yellow border thickness
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: FittedBox(
              fit: BoxFit.cover, // Set BoxFit to cover the entire container
              child: SizedBox(
                width: _videoMainController.value.size.width,
                height: _videoMainController.value.size.height,
                child: VideoPlayer(_videoMainController),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
