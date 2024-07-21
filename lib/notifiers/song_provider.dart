import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:mmusic/services/get_songs.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view_model/song_model.dart';
class SongsProvider extends ChangeNotifier {
  // Private variable to store the list of songs
  List<SongModel> _songs = [];

  late SongModel _song ;

  // Getter for accessing the list of songs
  List<SongModel> get songs => _songs;

  SongModel get song => _song;

  // Private variable to track the loading state
  bool _isLoading = true;

  // Getter for accessing the loading state
  bool get isLoading => _isLoading;

  // Asynchronous method to load songs
  Future<void> loadSongs(SongHandler songHandler) async {
    try {
      // Use the getSongs function to fetch the list of songs
      //_songs = await getSongsToStorage();
      //
      //_songs = (await getSongsToAPI()).cast<SongModel>();

      // Initialize the song handler with the loaded songs
      //await songHandler.initSongs(song: songs);

      // Update the loading state to indicate completion
      _isLoading = false;

      // Notify listeners about the changes in the state
      notifyListeners();
    } catch (e) {
      // Handle any errors that occur during the process
      debugPrint('Error loading songs: $e');
      // You might want to set _isLoading to false here as well, depending on your use case
    }
  }
  Future<void> loadSong(SongHandler songHandler) async {
    try {
      // Use the getSongs function to fetch the list of songs

      // Initialize the song handler with the loaded songs
      await songHandler.initSongs(song: song);

      // Update the loading state to indicate completion
      _isLoading = false;
      // Notify listeners about the changes in the state
      notifyListeners();
    } catch (e) {
      // Handle any errors that occur during the process
      debugPrint('Error loading songs: $e');
      // You might want to set _isLoading to false here as well, depending on your use case
    }
  }
}