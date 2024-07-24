import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/list_song/list_song_album.dart';
import 'package:mmusic/view/play_list/play_list_view.dart';
import 'package:mmusic/view_model/album_model.dart';
import 'package:mmusic/view_model/home_view_model.dart';
import 'package:mmusic/view_model/song_model.dart';
class YourPlaylistCell extends StatelessWidget {
  final AlbumModel albumModel;
  final SongHandler songHandler;

  const YourPlaylistCell({super.key, required this.albumModel, required this.songHandler});
  Future<void> _initSongsAndNavigate() async {
    final SongHandler songHD = SongHandler();
    List<String> id = albumModel.song;
    final List<SongModel> songs = await HomeViewModel().getSongByIds(id);

    if (songs.isEmpty) {
      _navigateToListSongCategory(songHandler: songHD);
      return; // Dừng thực hiện tiếp tục nếu không có bài hát
    }

    if (songHandler.mediaItem.value == null  || songHandler.queue.value.length <= 1 || songHandler.category != albumModel.id) {
      songHandler.initListSongs(songs: songs);
      songHandler.category = albumModel.id;

      _navigateToListSongCategory(songHandler: songHandler);
      return;
    }
    _navigateToListSongCategory(songHandler: songHandler);

  }
  void _navigateToListSongCategory({required SongHandler songHandler}) {
    Get.to(() => ListSongAlbum(songHandler: songHandler, albumModel: albumModel));
  }

  @override
  Widget build(BuildContext context) {
    var url = API().getUrl();
    return InkWell(
      onTap: (){
        _initSongsAndNavigate();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Image.network(
              url + albumModel.image,
              width: 84,
              height: 84,
              fit: BoxFit.fill,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    albumModel.name,
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    "${albumModel.song.length} bài hát",
                    style: TextStyle(
                        color: TColor.primaryText60,
                        fontSize: 15,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
