import 'package:flutter/material.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/list_song/list_song_artist.dart';
import 'package:mmusic/view_model/arist_model.dart';
import 'package:mmusic/view_model/home_view_model.dart';
import 'package:mmusic/view_model/song_model.dart';
import 'package:get/get.dart';
class YourArtistCell extends StatelessWidget {
  final Artist artist;
  final SongHandler songHandler;
  const YourArtistCell({super.key, required this.artist, required this.songHandler});

  Future<void> _initSongsAndNavigate() async {
    final SongHandler songHD = SongHandler();
    final List<SongModel> songs = await HomeViewModel().getSongByArtist(artist.id);

    if (songs.isEmpty) {
      Get.to(() => ListSongArtist(songHandler: songHD, mObj: artist));
      return; // Dừng thực hiện tiếp tục nếu không có bài hát
    }
    final currentMediaItem = songHandler.mediaItem.value;

    final shouldInitSongs = currentMediaItem == null ||
        currentMediaItem.artist != artist.name ||
        (currentMediaItem.artist == artist.name && songs.length > 1);

    if (shouldInitSongs) {
      songHandler.queue.value.clear();
      songHandler.initListSongs(songs: songs);
      Get.to(() => ListSongArtist(songHandler: songHandler, mObj: artist));
    } else {
      Get.to(() => ListSongArtist(songHandler: songHandler, mObj: artist));
    }
  }
  @override
  Widget build(BuildContext context) {
    String url  = API().getUrl();

    return InkWell(
      onTap: (){
        _initSongsAndNavigate();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5,bottom: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 43,
              child: ClipOval(
                child: Image.network(
                  url +artist.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                artist.name,
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
