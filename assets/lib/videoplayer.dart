import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:rstreamingent/sharedpreferenceutil.dart';
import 'package:video_player/video_player.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:flu_wake_lock/flu_wake_lock.dart';

class VideoPage extends StatefulWidget {
  final String videoPath;
  final int startingPosition;
  final String Title;

  const VideoPage({
    required this.videoPath,
    required this.startingPosition,
    required this.Title,
  });

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  double _sliderValue = 0.0;
  bool _controlsVisible = true;
  Timer? _hideControlsTimer;
  double _brightnessValue = 0.0;
  double _volumeValue = 0.0;
  bool _isBrightnessAdjusting = false;

  int _currentAspectRatioIndex = 0;
  FluWakeLock _fluWakeLock = FluWakeLock();

  List<double> _aspectRatios = [20 / 9, 16 / 9];

  @override
  void initState() {
    _fluWakeLock.enable();
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);

    _controller = VideoPlayerController.network(
      widget.videoPath,
    )..initialize().then((_) async {
      int lastPausedPosition =
      await SharedPreferencesUtils.getLastPausedPosition(widget.videoPath);
      setState(() {
        _controller.seekTo(Duration(seconds: lastPausedPosition));
        _controller.play();
      });
    });

    _controller.addListener(_onControllerUpdated);

    _startHideControlsTimer();
  }

  @override
  void dispose() {
    _fluWakeLock.disable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller.dispose();
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  void _onControllerUpdated() {
    if (_controller.value.isPlaying) {
      _startHideControlsTimer();
    }
    setState(() {
      _sliderValue = _controller.value.position.inMilliseconds.toDouble();
    });
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(Duration(seconds: 60), () {
      setState(() {
        _controlsVisible = false;
      });
    });
  }

  void _showControls() {
    setState(() {
      _controlsVisible = true;
    });
    _startHideControlsTimer();
  }

  void _handleDoubleTap(double scale) {
    final position = _controller.value.position +
        Duration(seconds: scale < 0 ? -10 : 10);
    _controller.seekTo(position);
    _showDoubleTapIcon(scale < 0 ? Icons.fast_rewind : Icons.fast_forward);
  }

  void _showDoubleTapIcon(IconData icon) {
    setState(() {
      _doubleTapIcon = Icon(icon, color: Colors.white, size: 48);
      _doubleTapIconOpacity = 1.0;
    });

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _doubleTapIconOpacity = 0.0;
      });
    });
  }

  Icon? _doubleTapIcon;
  double _doubleTapIconOpacity = 0.0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          double sensitivity = 0.005;
          double delta = details.primaryDelta! * sensitivity;

          if (details.globalPosition.dx < MediaQuery.of(context).size.width / 2) {
            _brightnessValue = (_brightnessValue - delta).clamp(0.0, 1.0);
            ScreenBrightness.instance.setScreenBrightness(_brightnessValue);
            setState(() {
              _isBrightnessAdjusting = true;
            });
          } else {
            _volumeValue = (_volumeValue - delta).clamp(0.0, 1.0);
            FlutterVolumeController.setVolume(_volumeValue);
            setState(() {
              _isBrightnessAdjusting = false;
            });
          }
        },
        onVerticalDragEnd: (_) {
          setState(() {
            _isBrightnessAdjusting = false;
          });
        },
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (_controlsVisible) {
                  setState(() {
                    _controlsVisible = false;
                  });
                } else {
                  _showControls();
                }
              },
              onDoubleTapDown: (details) {
                if (details.globalPosition.dx < MediaQuery.of(context).size.width / 2) {
                  _handleDoubleTap(-1.0);
                } else {
                  _handleDoubleTap(1.0);
                }
              },
              child: Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _aspectRatios[_currentAspectRatioIndex],
                  child: VideoPlayer(_controller),
                )
                    : CircularProgressIndicator(),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 24,
              top: MediaQuery.of(context).size.height / 2 - 24,
              child: AnimatedOpacity(
                opacity: _doubleTapIconOpacity,
                duration: Duration(milliseconds: 300),
                child: _doubleTapIcon ?? Container(),
              ),
            ),
            AnimatedOpacity(
              opacity: _controlsVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            SharedPreferencesUtils.saveLastPausedPosition(
                                widget.videoPath,
                                _controller.value.position.inSeconds);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Text(
                        widget.Title,
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDuration(_controller.value.position),
                              style: TextStyle(color: Colors.white),
                            ),
                            Expanded(
                              flex: 1,
                              child: Slider(
                                value: _sliderValue,
                                onChanged: (value) {
                                  final position = Duration(milliseconds: value.toInt());
                                  _controller.seekTo(position);
                                },
                                min: 0.0,
                                max: _controller.value.duration.inMilliseconds.toDouble(),
                                activeColor: Colors.amber,
                                inactiveColor: Colors.amberAccent.withOpacity(0.2),
                              ),
                            ),
                            Text(
                              formatDuration(_controller.value.duration),
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.aspect_ratio,
                                size: 35,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _currentAspectRatioIndex =
                                      (_currentAspectRatioIndex + 1) %
                                          _aspectRatios.length;
                                });
                              },
                            ),
                          ],
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.fast_rewind,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final position = _controller.value.position -
                                      Duration(seconds: 5);
                                  _controller.seekTo(position);
                                },
                              ),
                              SizedBox(width: 20),
                              IconButton(
                                icon: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (_controller.value.isPlaying) {
                                      _controller.pause();
                                    } else {
                                      _controller.play();
                                    }
                                  });
                                },
                              ),
                              SizedBox(width: 20),
                              IconButton(
                                icon: Icon(
                                  Icons.fast_forward,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final position = _controller.value.position +
                                      Duration(seconds: 5);
                                  _controller.seekTo(position);
                                },
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_isBrightnessAdjusting)
              Positioned(
                right: 20,
                top: 60,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Container(
                    height: MediaQuery.sizeOf(context).height / 2,
                    child: Row(
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2,
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 5.0,
                            ),
                            overlayShape: RoundSliderOverlayShape(
                              overlayRadius: 20.0,
                            ),
                          ),
                          child: Slider(
                            value: _brightnessValue,
                            onChanged: (value) {
                              setState(() {
                                _brightnessValue = value;
                              });
                              ScreenBrightness.instance.setScreenBrightness(value);
                            },
                            min: 0.0,
                            max: 1.0,
                            activeColor: Colors.blueAccent,
                          ),
                        ),
                        Icon(Icons.brightness_6_outlined),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);
    String formattedDuration = '';
    if (hours > 0) {
      formattedDuration += '$hours:';
    }
    formattedDuration +=
    '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return formattedDuration;
  }
}