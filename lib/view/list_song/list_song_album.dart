import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/common_widget/songs_playlist_cell.dart';
import 'package:mmusic/components/player_deck.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view_model/album_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:get/get.dart';
class ListSongAlbum extends StatefulWidget {
  final SongHandler songHandler;
  final AlbumModel albumModel;
  const ListSongAlbum({super.key, required this.songHandler, required this.albumModel});
  @override
  State<ListSongAlbum> createState() => _ListSongAlbumState();
}

class _ListSongAlbumState extends State<ListSongAlbum> {
  late AutoScrollController _autoScrollController;
  String url = API().getUrl();

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
            "Album",
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
              child: Container(
                padding:const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Image.network(
                      url + widget.albumModel.image,
                      width: double.maxFinite,
                      height: 320,
                      fit: BoxFit.cover,),
                    Container(
                      margin:const  EdgeInsets.symmetric(vertical: 10),
                      child: Text(widget.albumModel.name, style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 34,
                          fontWeight: FontWeight.w900
                      )),
                    ),
                    Text(widget.albumModel.title,
                      style: TextStyle(
                          color: TColor.primaryText60,
                          fontSize: 13,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    StreamBuilder<List<MediaItem>>(
                        stream: _getQueueStream(),
                        builder: (context, snapshot) {
                          List<MediaItem> songs = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: songs.length,
                            itemBuilder: (context, index) {
                              return SongsPlaylistCell(
                                mObj: songs[index],
                                songHandler: widget.songHandler,
                                isArtist: false,
                                songs: songs,
                                index: index,
                              );
                            },
                          );
                        }
                    ),
                    const SizedBox(height: 30,),
                    PlayerDeck(songHandler: widget.songHandler, isLast: true, onTap: _scrollTo)
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
          child: const SizedBox(height: 30,width: double.maxFinite,),
        )
      ],
    );
  }
  Stream<List<MediaItem>> _getQueueStream() {
    return widget.songHandler.queue.stream; // Truy cập vào queue của songHandler
  }
}

