import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';


void main() {
  runApp(const VideoPlayerApp());
}

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      debugShowCheckedModeBanner: false,
      home: const VideoPlayerScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class  VideoPlayerScreen extends StatefulWidget {
  const  VideoPlayerScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
    late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://cdn.trendybeatz.com/video/Simi-Logba-Logba-Video-(TrendyBeatz.com).mp4',
    )..initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  }
  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Video Player",
        style: GoogleFonts.roboto(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 30,),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: _controller.value.isInitialized?
        AspectRatio(aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),): Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _controller.value.isPlaying?
                _controller.pause():_controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying? Icons.pause :Icons.play_arrow,
          size: 40,
        ),
        //play icon
      ),
    );
  }
}