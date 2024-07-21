import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/common_widget/songs_playlist_cell.dart';
import 'package:mmusic/components/player_deck.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view_model/arist_model.dart';
import 'package:mmusic/view_model/home_view_model.dart';
import 'package:mmusic/view_model/song_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ListSongArtist extends StatefulWidget {
  final SongHandler songHandler;
  final Artist mObj;

  const ListSongArtist({super.key, required this.songHandler, required this.mObj});

  @override
  _ListSongArtistState createState() => _ListSongArtistState();
}

class _ListSongArtistState extends State<ListSongArtist> {
  late AutoScrollController _autoScrollController;

  @override
  void initState() {
    super.initState();
    _autoScrollController = AutoScrollController();
  }

  @override
  void dispose() {
    _autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String url = API().getUrl();
    final Future<List<SongModel>> songArr = HomeViewModel().getSongByArtist(widget.mObj.id);

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
            weight: 28,
          ),
        ),
        title: Center(
          child: Text(
            "Nghệ sĩ",
            style: TextStyle(
                color: TColor.primaryText80,
                fontSize: 20,
                fontWeight: FontWeight.w600
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
                weight: 24,
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
              width: double.maxFinite,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.network(url + widget.mObj.image, width: 263, height: 252, fit: BoxFit.cover,),
                  Text(widget.mObj.name, style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 34,
                      fontWeight: FontWeight.w900
                  )),
                  Text(widget.mObj.title,
                    style: TextStyle(
                        color: TColor.primaryText60,
                        fontSize: 13,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  FutureBuilder<List<SongModel>>(
                    future: songArr,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data found'));
                      } else {
                        final songs = snapshot.data!;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          widget.songHandler.initListSongs(songs: songs);
                        });
                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: songs.length,
                          itemBuilder: (context, index) {
                            return SongsPlaylistCell(mObj: songs[index], songHandler: widget.songHandler,isArtist: true,);
                          },
                        );
                      }
                    },
                  ),
                  PlayerDeck(songHandler: widget.songHandler, isLast: true, onTap: _scrollTo)
                ],
              ),
            ),
          ),
          _buildPlayerDeck()
        ],
      ),
    );
  }

  void _scrollTo(int index) {
    _autoScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
      duration: const Duration(milliseconds: 800),
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
          child: const SizedBox(height: 30,),
        )
      ],
    );
  }
}
