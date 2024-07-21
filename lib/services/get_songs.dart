import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/services/request_songs_permission.dart';
import 'package:mmusic/services/song_model_to_media_item.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<List<MediaItem>> getSongsToStorage() async {
  try {
    // Ensure that the necessary permissions are granted
    await requestSongPermission();

    // List to store the MediaItems representing songs
    final List<MediaItem> songs = [];

    // Create an instance of OnAudioQuery for querying songs
    final OnAudioQuery onAudioQuery = OnAudioQuery();

    // Query the device for song information using OnAudioQuery
    final List<SongModel> songModels = await onAudioQuery.querySongs();

    // Convert each SongModel to a MediaItem and add it to the list of songs
    for (final SongModel songModel in songModels) {
      final MediaItem song = await songToMediaItem(songModel);
      songs.add(song);
    }

    // Return the list of songs
    return songs;
  } catch (e) {
    // Handle any errors that occur during the process
    debugPrint('Error fetching songs: $e');
    return []; // Return an empty list in case of error
  }
}
Future<List<MediaItem>> getSongsToAPI() async {
  final player = AudioPlayer();
  final url = API().getUrl();
  final data = jsonDecode(await API().getAllSong())['success'] as List;
  // Tạo một danh sách các Future<MediaItem>
  List<Future<MediaItem>> songFutures = data.map((item) async {
    var duration = await player.setUrl(url + item['song']);
    int index = data.indexOf(item);
    debugPrint(index.toString());
    return MediaItem(
      id: url + item['song'],
      title: item['name'],
      artist: '123', // Bạn có thể cập nhật thông tin này từ API
      displayDescription: index.toString(),
      artUri: Uri.parse(url + item['image']),
      duration: duration,
    );
  }).toList();
  // Đợi tất cả các Future<MediaItem> hoàn thành và trả về danh sách MediaItem
  List<MediaItem> songs = await Future.wait(songFutures);
  return songs;
}