import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewCard extends StatefulWidget {
  final File videoFile;
  final VoidCallback onTap;

  const VideoPreviewCard({
    super.key,
    required this.videoFile,
    required this.onTap,
  });

  @override
  State<VideoPreviewCard> createState() => _VideoPreviewCardState();
}

class _VideoPreviewCardState extends State<VideoPreviewCard> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AspectRatio(
          aspectRatio: _isInitialized ? _controller.value.aspectRatio : 16 / 9,
          child: Container(
            color: Colors.black12,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_isInitialized)
                  VideoPlayer(_controller)
                else
                  const Center(child: CircularProgressIndicator()),
                
                // Иконка Play поверх видео
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.play_circle_fill,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}