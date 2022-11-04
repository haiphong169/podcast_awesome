import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:podcast_awesome/notifiers/play_button_notifier.dart';
import 'package:podcast_awesome/notifiers/progress_notifier.dart';
import 'package:podcast_awesome/widgets/episodes/episode.dart';

import 'notifiers/repeat_button_notifier.dart';

class PlayerManager {
  static final PlayerManager _playerManager = PlayerManager._internal();

  factory PlayerManager() {
    return _playerManager;
  }

  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;

  final progressNotifier = ProgressNotifier();
  // final currentEpisode = ValueNotifier<Episode>();
  final playButtonNotifier = PlayButtonNotifier();
  final playlistNotifier = ValueNotifier<List<Episode>>([]);
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(false);
  final isLastSongNotifier = ValueNotifier<bool>(false);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  PlayerManager._internal() {
    _init();
  }

  void _init() async {
    _setUpAudioPlayer();
    _listenForChangesInPlayerState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
  }

  void _setUpAudioPlayer() async {
    _audioPlayer = AudioPlayer();
    _playlist = ConcatenatingAudioSource(children: []);
    await _audioPlayer.setAudioSource(_playlist);
  }

  void _listenForChangesInPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  void _listenForChangesInPlayerPosition() {
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInBufferedPosition() {
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInTotalDuration() {
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void addSong(Episode episode) {
    final songNumber = _playlist.length + 1;
    final song = Uri.parse(episode.mp3Url);
    _playlist.add(AudioSource.uri(song,
        tag: MediaItem(
            id: songNumber.toString(),
            title: episode.title,
            artUri: Uri.parse(episode.image))));
    print(_playlist.length);
  }

  void addSongToStartOfPlaylist(Episode episode) {
    final songNumber = _playlist.length + 1;
    final song = Uri.parse(episode.mp3Url);
    _playlist.insert(
        0,
        AudioSource.uri(song,
            tag: MediaItem(
                id: songNumber.toString(),
                title: episode.title,
                artUri: Uri.parse(episode.image))));
  }

  void onRepeatButtonPressed() {
    repeatButtonNotifier.nextState();
    switch (repeatButtonNotifier.value) {
      case RepeatState.off:
        _audioPlayer.setLoopMode(LoopMode.off);
        break;
      case RepeatState.repeatSong:
        _audioPlayer.setLoopMode(LoopMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioPlayer.setLoopMode(LoopMode.all);
        break;
    }
  }

  void onPreviousSongButtonPressed() {
    _audioPlayer.seekToPrevious();
  }

  void onNextSongButtonPressed() {
    _audioPlayer.seekToNext();
  }

  void onShuffleButtonPressed() async {
    isShuffleModeEnabledNotifier.value = true;
    final isNotEnabled = !_audioPlayer.shuffleModeEnabled;
    print(isNotEnabled);

    if (isNotEnabled) {
      await _audioPlayer.shuffle();
      isShuffleModeEnabledNotifier.value = true;
    } else {
      await _audioPlayer.setShuffleModeEnabled(isNotEnabled);
      isShuffleModeEnabledNotifier.value = false;
    }
  }
}
