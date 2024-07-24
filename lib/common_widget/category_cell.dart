import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/list_song/list_song_category.dart';
import 'package:mmusic/view_model/category_model.dart';
import 'package:mmusic/view_model/home_view_model.dart';
import 'package:mmusic/view_model/song_model.dart';
import 'package:get/get.dart';

class CategoryCell extends StatefulWidget {
  final SongHandler songHandler;
  final CategoryModel category;
  const CategoryCell({super.key, required this.songHandler, required this.category});

  @override
  _CategoryCellState createState() => _CategoryCellState();
}

class _CategoryCellState extends State<CategoryCell> {
  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    _backgroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  Future<void> _initSongsAndNavigate() async {
    final SongHandler songHD = SongHandler();
    String id = widget.category.id;
    final List<SongModel> songs = await HomeViewModel().getSongByCategory(id);

    if (songs.isEmpty) {
      _navigateToListSongCategory(songHandler: songHD);
      return; // Dừng thực hiện tiếp tục nếu không có bài hát
    }

    if (widget.songHandler.mediaItem.value == null ||
        widget.songHandler.queue.value.length <= 1 ||
        widget.songHandler.category != widget.category.id) {

      widget.songHandler.initListSongs(songs: songs);
      widget.songHandler.category = widget.category.id;
      _navigateToListSongCategory(songHandler: widget.songHandler);
      return;
    }
    _navigateToListSongCategory(songHandler: widget.songHandler);
  }

  void _navigateToListSongCategory({required SongHandler songHandler}) {
    Get.to(() => ListSongCategory(songHandler: songHandler, mObj: widget.category));
  }

  @override
  Widget build(BuildContext context) {
    String url = API().getUrl();
    return InkWell(
      onTap: () {
        _initSongsAndNavigate();
      },
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                widget.category.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: TColor.primaryText,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    right: -15,
                    bottom: -20,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(3.1415926535897932 / 4.5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(48),
                          child: Image.network(
                            url + widget.category.image,
                            width: 85,
                            height: 85,
                            fit: BoxFit.cover,
                            isAntiAlias: true,
                          ),
                        ),
                      ),
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
