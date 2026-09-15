import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';

import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/models/expense_model.dart';

import 'package:track_expenses/main.dart';
import 'package:track_expenses/screens/full_sccreen_image.dart';
import 'package:track_expenses/utils/type_extension.dart';

class CustomTransactions extends StatefulWidget {
  const CustomTransactions({super.key, required this.expenseModel});
  final ExpenseModel expenseModel;

  @override
  State<CustomTransactions> createState() => _CustomTransactionsState();
}

class _CustomTransactionsState extends State<CustomTransactions>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = widget.expenseModel.income;
    final absValue = widget.expenseModel.value.abs();

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.white,
                    child: SvgPicture.asset(
                      widget.expenseModel.type.name.checkType,
                      colorFilter: const ColorFilter.mode(
                        AppColors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.expenseModel.note ?? '',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        ' ${widget.expenseModel.type.name}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                   Spacer(),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: absValue),
                    duration:  Duration(milliseconds: 4000),
                    curve: Curves.easeOutQuint,
                    builder: (context, double value, Widget? child) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        '${isIncome ? '+' : '-'}\$${value.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Jet',
                          color: isIncome ? AppColors.green : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(height: 20),
              Builder(
                builder: (context) {
                  final imagePath = widget.expenseModel.image;

                  if (imagePath == null || imagePath.isEmpty) {
                    return SizedBox();
                  }

                  final file = File(imagePath);
                  final ext = path.extension(imagePath).toLowerCase();

                  final isImage = [
                    '.png',
                    '.jpg',
                    '.jpeg',
                    '.gif',
                    '.bmp',
                    '.webp',
                    '.heic',
                  ].contains(ext);

                  final isMusic = [
                    '.mp3',
                    '.wav',
                    '.aac',
                    '.m4a',
                    '.ogg',
                    '.flac',
                    '.wma',
                  ].contains(ext);

                  if (isImage) {
                    return SizedBox(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FullSccreenImage(rasm: file),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'rasm1',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    file,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                SharePlus.instance.share(
                                  ShareParams(
                                    files: [XFile(widget.expenseModel.image!)],
                                  ),
                                );
                              },
                              icon: Icon(CupertinoIcons.share),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (isMusic) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (modalContext) {
                            final trackTitle =
                                widget.expenseModel.note?.isNotEmpty == true
                                ? widget.expenseModel.note!
                                : path.basename(file.path);

                            return Container(
                              height:
                                  MediaQuery.of(modalContext).size.height *
                                  0.75,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                ),
                              ),
                              child: StreamBuilder<PlaybackState>(
                                stream: audioHandler.playbackState,
                                builder: (context, snapshot) {
                                  final playbackState = snapshot.data;
                                  final playing =
                                      playbackState?.playing ?? false;
                                  final processingState =
                                      playbackState?.processingState;
                                  final isCurrentItem =
                                      audioHandler.mediaItem.value?.id ==
                                      file.path;
                                  final isCompleted =
                                      processingState ==
                                      AudioProcessingState.completed;

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 400,
                                          height: 400,
                                          decoration: BoxDecoration(
                                            color: AppColors.lgrey,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Icon(
                                            CupertinoIcons.music_note_2,
                                            size: 175,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                       SizedBox(height: 16),

                                      Text(
                                        trackTitle,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 6),

                                      Padding(
                                        padding:  EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: IconButton(
                                          iconSize: 32,
                                          icon:  Icon(
                                            CupertinoIcons.share,
                                          ),
                                          onPressed: () {
                                            SharePlus.instance.share(
                                              ShareParams(
                                                files: [XFile(file.path)],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Spacer(),

                                      StreamBuilder<MediaItem?>(
                                        stream: audioHandler.mediaItem,
                                        builder: (context, mediaSnapshot) {
                                          final duration =
                                              mediaSnapshot.data?.duration ??
                                              Duration.zero;
                                          final position = isCompleted
                                              ? Duration.zero
                                              : (playbackState?.position ??
                                                    Duration.zero);

                                          double maxSeconds = duration.inSeconds
                                              .toDouble();
                                          double currentSeconds = position
                                              .inSeconds
                                              .toDouble();

                                          if (currentSeconds > maxSeconds)
                                            // ignore: curly_braces_in_flow_control_structures
                                            currentSeconds = maxSeconds;
                                          if (maxSeconds <= 0) maxSeconds = 1.0;

                                          return Column(
                                            children: [
                                              Slider(
                                                value: currentSeconds.clamp(
                                                  0.0,
                                                  maxSeconds,
                                                ),
                                                max: maxSeconds,
                                                onChanged: (value) {
                                                  audioHandler.seek(
                                                    Duration(
                                                      seconds: value.toInt(),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      _formatDuration(position),
                                                    ),
                                                    Text(
                                                      _formatDuration(duration),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),

                                       SizedBox(height: 10),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              iconSize: 32,
                                              icon:  Icon(Icons.replay_10),
                                              onPressed: () async {
                                                final currentPosition =
                                                    audioHandler
                                                        .playbackState
                                                        .value
                                                        .position;
                                                final newPosition =
                                                    currentPosition -
                                                     Duration(seconds: 10);
                                        
                                                await audioHandler.seek(
                                                  newPosition < Duration.zero
                                                      ? Duration.zero
                                                      : newPosition,
                                                );
                                              },
                                            ),
                                            IconButton(
                                              iconSize: 64,
                                              icon: Icon(
                                                playing &&
                                                        isCurrentItem &&
                                                        !isCompleted
                                                    ? CupertinoIcons
                                                          .pause_circle_fill
                                                    : CupertinoIcons
                                                          .play_circle_fill,
                                              ),
                                              onPressed: () async {
                                                if (isCurrentItem) {
                                                  if (isCompleted) {
                                                    await audioHandler.seek(
                                                      Duration.zero,
                                                    );
                                                    await audioHandler.play();
                                                  } else if (playing) {
                                                    await audioHandler.pause();
                                                  } else {
                                                    await audioHandler.play();
                                                  }
                                                } else {
                                                  audioHandler.playFromFile(
                                                    filePath: file.path,
                                                    title: trackTitle,
                                                    album: widget
                                                        .expenseModel
                                                        .type
                                                        .name,
                                                  );
                                                }
                                              },
                                            ),
                                            IconButton(
                                              iconSize: 32,
                                              icon: const Icon(Icons.forward_10),
                                              onPressed: () async {
                                                final currentPosition =
                                                    audioHandler
                                                        .playbackState
                                                        .value
                                                        .position;
                                                final maxDuration =
                                                    audioHandler
                                                        .mediaItem
                                                        .value
                                                        ?.duration ??
                                                    Duration.zero;
                                                final newPosition =
                                                    currentPosition +
                                                    const Duration(seconds: 10);
                                        
                                                await audioHandler.seek(
                                                  newPosition > maxDuration
                                                      ? maxDuration
                                                      : newPosition,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: _buildAudioPlayerWidget(file),
                    );
                  } else {
                    return InkWell(
                      onTap: () => OpenFile.open(file.path),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: const Icon(Icons.insert_drive_file),
                            title: Text(path.basename(file.path)),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAudioPlayerWidget(File file) {
    final trackTitle = widget.expenseModel.note?.isNotEmpty == true
        ? widget.expenseModel.note!
        : path.basename(file.path);

    return StreamBuilder<PlaybackState>(
      stream: audioHandler.playbackState,
      builder: (context, snapshot) {
        final playbackState = snapshot.data;
        final playing = playbackState?.playing ?? false;
        final processingState = playbackState?.processingState;
        final isCurrentItem = audioHandler.mediaItem.value?.id == file.path;

        final isCompleted = processingState == AudioProcessingState.completed;

        if (playing && isCurrentItem && !isCompleted) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: AppColors.lgrey,
            child: Column(
              children: [
                ListTile(
                  leading: IconButton(
                    onPressed: () async {
                      if (isCurrentItem) {
                        if (isCompleted) {
                          await audioHandler.seek(Duration.zero);
                          await audioHandler.play();
                        } else if (playing) {
                          await audioHandler.pause();
                        } else {
                          await audioHandler.play();
                        }
                      } else {
                        audioHandler.playFromFile(
                          filePath: file.path,
                          title: trackTitle,
                          album: widget.expenseModel.type.name,
                        );
                      }
                    },
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: _animationController,
                    ),
                  ),
                  title: Text(
                    trackTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      SharePlus.instance.share(
                        ShareParams(files: [XFile(file.path)]),
                      );
                    },
                    icon: const Icon(CupertinoIcons.share),
                  ),
                ),
                if (isCurrentItem)
                  StreamBuilder<MediaItem?>(
                    stream: audioHandler.mediaItem,
                    builder: (context, mediaSnapshot) {
                      final duration =
                          mediaSnapshot.data?.duration ?? Duration.zero;

                      final position = isCompleted
                          ? Duration.zero
                          : (playbackState?.position ?? Duration.zero);

                      double maxSeconds = duration.inSeconds.toDouble();
                      double currentSeconds = position.inSeconds.toDouble();

                      if (currentSeconds > maxSeconds)
                        currentSeconds = maxSeconds;
                      if (maxSeconds <= 0) maxSeconds = 1.0;

                      return Slider(
                        value: currentSeconds.clamp(0.0, maxSeconds),
                        max: maxSeconds,
                        onChanged: (value) {
                          audioHandler.seek(Duration(seconds: value.toInt()));
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
