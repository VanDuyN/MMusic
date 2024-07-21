import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/view_model/song_model.dart';

// Class for handling audio playback using AudioService and Just Audio
class SongHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  // Create an instance of the AudioPlayer class from just_audio package
  final AudioPlayer audioPlayer = AudioPlayer();

  // Function to create an audio source from a MediaItem
  UriAudioSource _createAudioSource(SongModel song) {
    debugPrint(song.song);
    var url = API().getUrl();
    debugPrint(url + song.song);
    return ProgressiveAudioSource(Uri.parse(url + song.song));
  }

  Future<String> getNameArtist(String id) async {
    // Khai báo biến name với kiểu dữ liệu String
    String name;

    // Gọi API và chuyển đổi JSON trả về thành một map
    final jsonResponse = jsonDecode(await API().getArtistById(id));
    // Kiểm tra trạng thái của JSON trả về
    if (jsonResponse['status']) {
      // Lấy giá trị của trường 'name' trong phần 'success' của JSON
      name = jsonResponse['success']['name'];
      return name;
    }
    // Nếu không có dữ liệu hợp lệ, trả về một chuỗi rỗng
    return "";
  }

  // Listen for changes in the current song index and update the media item
  void _listenForCurrentSongIndexChanges() {
    audioPlayer.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      mediaItem.add(playlist[index]);
    });
  }

  // Broadcast the current playback state based on the received PlaybackEvent
  void _broadcastState(PlaybackEvent event) {
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[audioPlayer.processingState]!,
      playing: audioPlayer.playing,
      updatePosition: audioPlayer.position,
      bufferedPosition: audioPlayer.bufferedPosition,
      speed: audioPlayer.speed,
      queueIndex: event.currentIndex,
    ));
  }

  // Function to initialize the songs and set up the audio player
  Future<void> initListSongs({required List<SongModel> songs}) async {
    // Listen for playback events and broadcast the state
    audioPlayer.playbackEventStream.listen(_broadcastState);

    // Create a list of audio sources from the provided songs
    final audioSource = songs.map(_createAudioSource).toList();

    // Set the audio source of the audio player to the concatenation of the audio sources
    await audioPlayer.setAudioSource(ConcatenatingAudioSource(children: audioSource));

    // Add the songs to the queue
    queue.value.clear();

    for (var song in songs) {
      final artistName = await getNameArtist(song.idArtist.join(''));
      final audioSource = _createAudioSource(song);
      await audioPlayer.setAudioSource(audioSource);
      queue.value.add(
        MediaItem(
          id: '${API().getUrl()}${song.song}',
          title: song.name,
          artist: artistName,
          displayDescription: song.id.toString(),
          artUri: Uri.parse('${API().getUrl()}${song.image}'),
          duration:audioSource.duration
        ),
      );
    }

    queue.add(queue.value);

    // Listen for changes in the current song index
    _listenForCurrentSongIndexChanges();

    // Listen for processing state changes and skip to the next song when completed
    audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) skipToNext();
    });
  }

  Future<void> initSongs({required SongModel song}) async {
    // Listen for playback events and broadcast the state
    audioPlayer.playbackEventStream.listen(_broadcastState);
    final artistName = await getNameArtist(song.idArtist.join(''));

    // Check if the song is already in the queue
    final existingIndex = queue.value.indexWhere((item) => item.id == '${API().getUrl()}${song.song}');
    debugPrint(existingIndex.toString());
    if (existingIndex == 0) {
    } else {
      // Song is not in the queue, add it
      final audioSource = _createAudioSource(song);
      await audioPlayer.setAudioSource(audioSource);
      queue.value.clear();
      queue.value.add(
        MediaItem(
          id: '${API().getUrl()}${song.song}',
          title: song.name,
          artist: artistName,
          displayDescription: song.id.toString(),
          artUri: Uri.parse('${API().getUrl()}${song.image}'),
          duration: audioSource.duration,
        ),
      );
      queue.add(queue.value);

      // Listen for changes in the current song index
      _listenForCurrentSongIndexChanges();

      // Listen for processing state changes and skip to the next song when completed
      audioPlayer.processingStateStream.listen((state) {
        if (state == ProcessingState.completed) skipToNext();
      });
    }
  }



  // Play function to start playback
  @override
  Future<void> play() => audioPlayer.play();

  // Pause function to pause playback
  @override
  Future<void> pause() => audioPlayer.pause();

  // Seek function to change the playback position
  @override
  Future<void> seek(Duration position) => audioPlayer.seek(position);

  // Skip to a specific item in the queue and start playback
  @override
  Future<void> skipToQueueItem(int index) async {
    await audioPlayer.seek(Duration.zero, index: index);
    play();
  }

  // Skip to the next item in the queue
  @override
  Future<void> skipToNext() => audioPlayer.seekToNext();

  // Skip to the previous item in the queue
  @override
  Future<void> skipToPrevious() => audioPlayer.seekToPrevious();
}