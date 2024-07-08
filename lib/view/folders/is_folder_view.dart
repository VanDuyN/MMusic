import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/components/for_you_list.dart';
import 'package:mmusic/components/player_deck.dart';
import 'package:mmusic/notifiers/song_provider.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/home/search_view_home.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
class IsFolderView extends StatefulWidget {
  final SongHandler songHandler;
  const IsFolderView({super.key, required this.songHandler});

  @override
  State<IsFolderView> createState() => _IsFolderViewState();
}

class _IsFolderViewState extends State<IsFolderView> {
  final AutoScrollController _autoScrollController = AutoScrollController();
  void _scrollTo(int index) {
    _autoScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
      duration: const Duration(milliseconds: 800),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<SongsProvider>(
      builder: (context, songsProvider, _) {
        // Scaffold widget for the app structure
        return Scaffold(
          appBar: AppBar(
            title: const Text("Thử mục của bạn"),
            actions: [
              // IconButton to navigate to the SearchScreen
              IconButton(
                onPressed: () => Get.to(
                      () => SearchViewHome(songHandler: widget.songHandler),
                  duration: const Duration(milliseconds: 700),
                  transition: Transition.rightToLeft,
                ),
                icon: const Icon(
                  Icons.search_rounded,
                ),
              ),
            ],
          ),
          body: songsProvider.isLoading
              ? _buildLoadingIndicator() // Display a loading indicator while songs are loading
              : _buildSongsList(songsProvider), // Display the list of songs
        );
      },
    );
  }
  // Method to build the loading indicator widget
  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        strokeCap: StrokeCap.round,
      ),
    );
  }
  // Method to build the main songs list with a player deck
  Widget _buildSongsList(SongsProvider songsProvider) {
    return Stack(
      children: [
        // SongsList widget to display the list of songs
        ForYouList(
          songHandler: widget.songHandler,
          songs: songsProvider.songs,
          autoScrollController: _autoScrollController,
        ),
        _buildPlayerDeck(), // PlayerDeck widget for music playback controls
      ],
    );
  }
  // Method to build the player deck widget
  Widget _buildPlayerDeck() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // PlayerDeck widget with controls and the ability to scroll to a specific song
        PlayerDeck(
          songHandler: widget.songHandler,
          isLast: false,
          onTap: _scrollTo,
        ),
      ],
    );
  }
}