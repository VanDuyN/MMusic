import 'package:flutter/material.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/list_song/list_song_category.dart';
import 'dart:math';
import 'package:mmusic/view_model/category_model.dart';
import 'package:mmusic/view_model/home_view_model.dart';
import 'package:mmusic/view_model/song_model.dart';
import 'package:get/get.dart';
class RecentlyCell extends StatelessWidget {
  final CategoryModel category;
  final SongHandler songHandler;
  const RecentlyCell({super.key,required this.category, required this.songHandler});
  Future<void> _initSongsAndNavigate() async {
    final SongHandler songHD = SongHandler();
    String id = category.id;
    final List<SongModel> songs = await HomeViewModel().getSongByCategory(id);

    if (songs.isEmpty) {
      _navigateToListSongCategory(songHandler: songHD);
      return; // Dừng thực hiện tiếp tục nếu không có bài hát
    }

    if (songHandler.mediaItem.value == null  || songHandler.queue.value.length <= 1 || songHandler.category != category.id) {
      songHandler.initListSongs(songs: songs);
      songHandler.category = category.id;

      _navigateToListSongCategory(songHandler: songHandler);
      return;
    }
    _navigateToListSongCategory(songHandler: songHandler);

  }

  void _navigateToListSongCategory({required SongHandler songHandler}) {
    Get.to(() => ListSongCategory(songHandler: songHandler, mObj: category));
  }

  @override
  Widget build(BuildContext context) {
    String url = API().getUrl();
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 5 , top: 40),
          padding: const EdgeInsets.only(bottom: 6.5),
          decoration: BoxDecoration(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
          child: InkWell(
            onTap: (){
              _initSongsAndNavigate();
            },
            child: Image.network(
                url+category.image,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30,top: 10,right: 5),
              child: Text(
                category.name,
                style: TextStyle(
                    color: TColor.primaryText80,
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
