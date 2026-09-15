import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayerHandler() {
    _initListeners();
  }

  void _initListeners() {
    // Слушаем изменение состояния плеера
    _player.onPlayerStateChanged.listen((state) {
      final isCompleted = state == PlayerState.completed;
      final isPlaying = state == PlayerState.playing;

      _broadcastState(
        playing: isPlaying,
        processingState: isCompleted
            ? AudioProcessingState.completed
            : AudioProcessingState.ready,
      );
    });

    // Отправляем текущую позицию ползунка
    _player.onPositionChanged.listen((position) {
      playbackState.add(
        playbackState.value.copyWith(updatePosition: position),
      );
    });

    // Обновляем длительность трека
    _player.onDurationChanged.listen((duration) {
      if (mediaItem.value != null) {
        mediaItem.add(mediaItem.value!.copyWith(duration: duration));
      }
    });
  }

  /// Воспроизведение нового файла
  Future<void> playFromFile({
    required String filePath,
    required String title,
    String album = 'Неизвестный альбом',
    String artist = 'Неизвестный исполнитель',
    String? artUri,
  }) async {
    final item = MediaItem(
      id: filePath,
      album: album,
      title: title,
      artist: artist,
      artUri: artUri != null ? Uri.parse(artUri) : null,
    );

    mediaItem.add(item);

    await _player.stop();
    await _player.play(DeviceFileSource(filePath));
  }

  @override
  Future<void> play() async {
    // Если трек дошел до конца, перематываем в начало и запускаем заново
    if (_player.state == PlayerState.completed) {
      await _player.seek(Duration.zero);
    }
    await _player.resume();
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
    playbackState.add(playbackState.value.copyWith(updatePosition: position));
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    _broadcastState(
      playing: false,
      processingState: AudioProcessingState.idle,
    );
  }

  void _broadcastState({
    required bool playing,
    AudioProcessingState processingState = AudioProcessingState.ready,
  }) {
    playbackState.add(
      PlaybackState(
        controls: [
          MediaControl.rewind,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.fastForward,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: processingState,
        playing: playing,
        updatePosition: playbackState.value.updatePosition,
      ),
    );
  }
}