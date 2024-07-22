import 'package:flutter/material.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/list_song/list_song_artist.dart';
import 'package:mmusic/view_model/arist_model.dart';
import 'package:get/get.dart';
import 'package:mmusic/view_model/home_view_model.dart';
import 'package:mmusic/view_model/song_model.dart';
class ArtistCell extends StatelessWidget {
  final Artist mObj;
  final SongHandler songHandler;
  const ArtistCell({super.key, required this.mObj, required this.songHandler});
  Future<void> _initSongsAndNavigate() async {
    final SongHandler songHD = SongHandler();
    final List<SongModel> songs = await HomeViewModel().getSongByArtist(mObj.id);

    if (songs.isEmpty) {
      Get.to(() => ListSongArtist(songHandler: songHD, mObj: mObj));
      return; // Dừng thực hiện tiếp tục nếu không có bài hát
    }
    final currentMediaItem = songHandler.mediaItem.value;
    final shouldInitSongs = currentMediaItem == null ||
        currentMediaItem.artist != mObj.name ||
        (currentMediaItem.artist == mObj.name && songs.length > 1);

    if (shouldInitSongs) {
      songHandler.queue.value.clear();
      songHandler.initListSongs(songs: songs);
      Get.to(() => ListSongArtist(songHandler: songHandler, mObj: mObj));
    } else {
      Get.to(() => ListSongArtist(songHandler: songHandler, mObj: mObj));
    }
  }
  @override
  Widget build(BuildContext context) {
    final url =API().getUrl();
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              _initSongsAndNavigate();
            },
            child: CircleAvatar(
              radius: 80,
              child: ClipOval(
                child: Image.network(
                  url+mObj.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
                mObj.name,
                style: TextStyle(
                  color: TColor.primaryText80,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
            ),
          ),
        ],
      ),
    );
  }
}
