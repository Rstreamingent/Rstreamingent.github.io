
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'auth_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.addListener(() {
          if (!_controller.value.isPlaying && _controller.value.duration == _controller.value.position) {
            // Video has ended, navigate to AuthPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AuthPage()),
            );
          }
        });
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      body: Container(
        color: Color(0xff181818),
        child: _controller.value.isInitialized
            ? Center(

            child: VideoPlayer(_controller),

        )
            : const Center(
          child: CircularProgressIndicator(),
        ),
      ),

    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   late VideoPlayerController _videoPlayerController;
//   bool _isPlaying = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController = VideoPlayerController.asset('assets/video/video.mp4')
//       ..initialize().then((_) {
//         setState(() {});
//         _videoPlayerController.play();
//         _isPlaying = true;
//       });
//
//     _videoPlayerController.addListener(() {
//       if (_videoPlayerController.value.position ==
//           _videoPlayerController.value.duration) {
//         _videoPlayerController.pause();
//         _isPlaying = false;
//         // Navigate to the main app screen after the video is finished
//         Navigator.pushReplacementNamed(context, '/main');
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: _videoPlayerController.value.isInitialized
//             ? AspectRatio(
//           aspectRatio: _videoPlayerController.value.aspectRatio,
//           child: VideoPlayer(_videoPlayerController),
//         )
//             : const CircularProgressIndicator(),
//       ),
//     );
//   }
// }