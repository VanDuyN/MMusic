import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/common_widget/songs_playlist_cell.dart';
import 'package:mmusic/components/player_deck.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view_model/home_view_model.dart';
import 'package:mmusic/view_model/song_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListSongFavourite extends StatefulWidget {
  final SongHandler songHandler;
  const ListSongFavourite({super.key, required this.songHandler});

  @override
  State<ListSongFavourite> createState() => _ListSongFavouriteState();
}

class _ListSongFavouriteState extends State<ListSongFavourite> {
  late String _userEmail = '';
  late AutoScrollController _autoScrollController;
  late Future<List<String>?> _favoriteSongsFuture;
  late Future<String?> _emailFuture;

  @override
  void initState() {
    super.initState();
    _autoScrollController = AutoScrollController();
    _emailFuture = _getEmail();
  }

  Future<void> _initialize(String email) async {
    List<String> favoriteSongs = await HomeViewModel().getAllFavorite(email) ?? [];
    if (favoriteSongs.isNotEmpty) {
      await _initSongsAndNavigate(favoriteSongs);
    }
  }

  Future<void> _initSongsAndNavigate(List<String> listSong) async {
    List<SongModel> songs = await HomeViewModel().getSongByIds(listSong);
    widget.songHandler.initListSongs(songs: songs);
  }

  Widget _checkUser() {
    return FutureBuilder<String?>(
      future: _emailFuture,
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (userSnapshot.hasError) {
          return const Center(child: Text('Lỗi khi lấy thông tin người dùng'));
        }

        final userEmail = userSnapshot.data;
        if (userEmail == null) {
          return const Center(child: Text('Người dùng không đăng nhập'));
        }

        // Khởi tạo danh sách bài hát yêu thích
        _initialize(userEmail);

        return _checkFavorite(userEmail);
      },
    );
  }

  Widget _checkFavorite(String userEmail) {

    return FutureBuilder<List<String>?>(
      future: HomeViewModel().getAllFavorite(userEmail),
      builder: (context, songSnapshot) {
        if (songSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (songSnapshot.hasError) {
          return const Center(child: Text('Lỗi khi lấy thông tin yêu thích'));
        }
        final songs = songSnapshot.data;
        if (songs == null || songs.isEmpty) {
          return const Center(child: Text('Không có bài hát yêu thích nào'));
        }
        return StreamBuilder<List<MediaItem>>(
          stream: _getQueueStream(),
          builder: (context, snapshot) {
            final mediaItems = snapshot.data ?? [];
            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: mediaItems.length,
              itemBuilder: (context, index) {
                return SongsPlaylistCell(
                  mObj: mediaItems[index],
                  songHandler: widget.songHandler,
                  isArtist: false,
                  songs: mediaItems,
                  index: index,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildPlayerDeck() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        PlayerDeck(
          songHandler: widget.songHandler,
          isLast: false,
          onTap: _scrollTo,
        ),
        Container(
          color: TColor.bg,
          child: const SizedBox(height: 30, width: double.infinity),
        ),
      ],
    );
  }

  void _scrollTo(int index) {
    _autoScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _autoScrollController.dispose();
    super.dispose();
  }

  Future<String?> _getEmail() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString('token');
      if (token == null) return null;
      Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(token);
      return jwtDecodeToken['email'] as String?;
    } catch (e) {
      debugPrint('Error decoding token: $e');
      return null;
    }
  }

  Stream<List<MediaItem>> _getQueueStream() {
    return widget.songHandler.queue.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.bg,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
            size: 28,
          ),
        ),
        title: Center(
          child: Text(
            "Yêu thích",
            style: TextStyle(
              color: TColor.primaryText80,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _autoScrollController,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _checkUser(),
                    const SizedBox(height: 30),
                    PlayerDeck(songHandler: widget.songHandler, isLast: true, onTap: _scrollTo),
                  ],
                ),
              ),
            ),
          ),
          _buildPlayerDeck(),
        ],
      ),
    );
  }
}
