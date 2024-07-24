import 'package:flutter/material.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/list_song/list_song_album.dart';
import 'package:mmusic/view_model/album_model.dart';
import 'package:get/get.dart';
import 'package:mmusic/view_model/home_view_model.dart';
import 'package:mmusic/view_model/song_model.dart';
class ContinueCell extends StatelessWidget {
  final AlbumModel album;
  final SongHandler songHandler;
  const ContinueCell({super.key, required this.album, required this.songHandler,});
  Future<void> _initSongsAndNavigate() async {
    final SongHandler songHD = SongHandler();
    List<String> id = album.song;
    final List<SongModel> songs = await HomeViewModel().getSongByIds(id);

    if (songs.isEmpty) {
      _navigateToListSongCategory(songHandler: songHD);
      return; // Dừng thực hiện tiếp tục nếu không có bài hát
    }

    if (songHandler.mediaItem.value == null  || songHandler.queue.value.length <= 1 || songHandler.category != album.id) {
      songHandler.initListSongs(songs: songs);
      songHandler.category = album.id;

      _navigateToListSongCategory(songHandler: songHandler);
      return;
    }
    _navigateToListSongCategory(songHandler: songHandler);

  }
  void _navigateToListSongCategory({required SongHandler songHandler}) {
    Get.to(() => ListSongAlbum(songHandler: songHandler, albumModel: album));
  }
  @override
  Widget build(BuildContext context) {
    final url = API().getUrl();
    return InkWell(
      onTap: (){
        _initSongsAndNavigate();
      },
      child: Container(
        width: 183,
        height: 80,
        decoration: BoxDecoration(
          color: TColor.primaryItem20,
          borderRadius: BorderRadius.circular(9),
        ),
        //color: TColor.primaryItem20,
        margin: const EdgeInsets.symmetric(horizontal:5,vertical: 8),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.network(
                url + album.image,
                width: 65,
                height: 65,
                fit: BoxFit.cover,
              ),
            ),
            Center(
                child:
                Container(
                  padding:const EdgeInsets.only(left: 10,right: 5),
                    child: Text(
                      album.name,
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
