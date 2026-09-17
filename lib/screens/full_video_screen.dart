import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:video_player/video_player.dart';
import 'package:liquid_glass_easy/liquid_glass_easy.dart';

class FullVideoScreen extends StatefulWidget {
  const FullVideoScreen({super.key});

  @override
  State<FullVideoScreen> createState() => _FullVideoScreenState();
}

class _FullVideoScreenState extends State<FullVideoScreen>
    with TickerProviderStateMixin {
  late final AnimationController _playPauseIconController;
  late final AnimationController _controlsAnimationController;

  late final Animation<double> _btn1Scale;
  late final Animation<double> _btn2Scale;
  late final Animation<double> _btn3Scale;
  late final Animation<double> _sliderScale;

  late final VideoPlayerController _videoPlayerController;

  bool isVisible = true;
  Timer? _hideTimer;
  double currentSpeed = 1.0;

  @override
  void initState() {
    super.initState();

    _playPauseIconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _controlsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _btn1Scale = CurvedAnimation(
      parent: _controlsAnimationController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
      reverseCurve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    );

    _btn2Scale = CurvedAnimation(
      parent: _controlsAnimationController,
      curve: const Interval(0.2, 0.6, curve: Curves.easeOutBack),
      reverseCurve: const Interval(0.4, 0.8, curve: Curves.easeIn),
    );

    _btn3Scale = CurvedAnimation(
      parent: _controlsAnimationController,
      curve: const Interval(0.4, 0.8, curve: Curves.easeOutBack),
      reverseCurve: const Interval(0.2, 0.6, curve: Curves.easeIn),
    );

    _sliderScale = CurvedAnimation(
      parent: _controlsAnimationController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOutBack),
      reverseCurve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://fra.cloud.appwrite.io/v1/storage/buckets/6aa42198001612c273c0/files/6aa93a360002afb8cd22/view?project=6aa413fc001db8e22ee0',
      ),
    )
      ..initialize().then((v) {
        setState(() {
          _videoPlayerController.play();
          _playPauseIconController.forward();
        });
        _controlsAnimationController.forward();
        _startHideTimer();
      })
      ..addListener(() {
        if (mounted) setState(() {});
      });
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        _hideControls();
      }
    });
  }

  void _hideControls() {
    setState(() {
      isVisible = false;
    });
    _controlsAnimationController.reverse();
    _hideTimer?.cancel();
  }

  void _showControls() {
    setState(() {
      isVisible = true;
    });
    _controlsAnimationController.forward();
    _startHideTimer();
  }

  void _toggleControls() {
    if (isVisible) {
      _hideControls();
    } else {
      _showControls();
    }
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _playPauseIconController.dispose();
    _controlsAnimationController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: LiquidGlassButton(
            child: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actionsPadding:EdgeInsets.only(right: 12),
        actions: [
          LiquidGlassButton(
            child: const Icon(Icons.speed),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => LiquidGlassDialog(
                  child: StatefulBuilder(
                    builder: (context, dialogSetState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Playback Speed: ${currentSpeed.toStringAsFixed(2)}x',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Slider(
                            activeColor: AppColors.red,
                            min: 0.5,
                            max: 2.0,
                            divisions: 6,
                            value: currentSpeed,
                            onChanged: (v) {
                              _videoPlayerController.setPlaybackSpeed(v);
                              dialogSetState(() {
                                currentSpeed = v;
                              });
                              setState(() {});
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
        backgroundColor: AppColors.black,
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio > 0
              ? _videoPlayerController.value.aspectRatio
              : 16 / 9,
          child: !_videoPlayerController.value.isInitialized
              ? const CupertinoActivityIndicator(color: Colors.white10)
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _toggleControls,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                    Positioned(
                      
                      bottom: 0,
                      left: 14,
                      right: 14,
                      child: ScaleTransition(
                        scale: _sliderScale,
                        child: IgnorePointer(
                          ignoring: !isVisible,
                          child: Center(
                            child: LiquidGlassSlider(
                              activeColor: AppColors.red,
                              maximumValue: _videoPlayerController
                                  .value.duration.inSeconds
                                  .toDouble(),
                              value: _videoPlayerController
                                  .value.position.inSeconds
                                  .toDouble(),
                              onChanged: (v) {
                                _startHideTimer();
                                _videoPlayerController.seekTo(
                                  Duration(seconds: v.toInt()),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    IgnorePointer(
                      ignoring: !isVisible,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ScaleTransition(
                              scale: _btn1Scale,
                              child: LiquidGlassButton(
                                onPressed: () {
                                  _startHideTimer();
                                  _videoPlayerController.seekTo(
                                    Duration(
                                      seconds: _videoPlayerController
                                              .value.position.inSeconds -
                                          10,
                                    ),
                                  );
                                },
                                child: const Icon(Icons.replay_10_sharp),
                              ),
                            ),
                            ScaleTransition(
                              scale: _btn2Scale,
                              child: LiquidGlassButton(
                                onPressed: () {
                                  _startHideTimer();
                                  if (_videoPlayerController.value.isPlaying) {
                                    _playPauseIconController.reverse();
                                    _videoPlayerController.pause();
                                  } else {
                                    _playPauseIconController.forward();
                                    _videoPlayerController.play();
                                  }
                                },
                                child: !_videoPlayerController
                                            .value.isInitialized ||
                                        _videoPlayerController.value.isBuffering
                                    ? const CupertinoActivityIndicator(
                                        color: Colors.white10,
                                      )
                                    : AnimatedIcon(
                                        icon: AnimatedIcons.play_pause,
                                        progress: _playPauseIconController,
                                      ),
                              ),
                            ),
                            ScaleTransition(
                              scale: _btn3Scale,
                              child: LiquidGlassButton(
                                onPressed: () {
                                  _startHideTimer();
                                  _videoPlayerController.seekTo(
                                    Duration(
                                      seconds: _videoPlayerController
                                              .value.position.inSeconds +
                                          10,
                                    ),
                                  );
                                },
                                child: const Icon(Icons.forward_10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}