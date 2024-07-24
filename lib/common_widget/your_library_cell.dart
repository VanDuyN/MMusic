import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/main_player_music_view/main_player_view.dart';
import 'package:mmusic/view_model/song_model.dart';
import 'package:get/get.dart';
class LibraryCell extends StatelessWidget {
  final SongModel song;
  final SongHandler songHandler;
  const LibraryCell({super.key,required this.song, required this.songHandler});
  Future<String> getNameArtist(String id) async {
    String name;
    final jsonResponse = jsonDecode(await API().getArtistById(id));
    if (jsonResponse['status']) {
      name = jsonResponse['success']['name'];
      return name;
    }
    return "";
  }
  Future<String> _getArtistNames(SongModel song) async {
    final artistNames = await Future.wait(
        song.idArtist.map((id) => getNameArtist(id))
    );
    return artistNames.join(', ');
  }
  @override
  Widget build(BuildContext context) {
    String url = API().getUrl();
    return  Container(
      margin: const EdgeInsets.only(top: 10,bottom: 10),
      child: InkWell(
        onTap: () {
          songHandler.initSongs(song: song);
          Get.to(() => MainPlayerView(
            songHandler: songHandler,
            isLast: false,
            name: song.name,
          ));
        },
        child: Row(
          children:[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                url +song.image,
                width: 84,
                height: 82,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 270,
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    song.name,
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 17,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  FutureBuilder<String>(
                    future: _getArtistNames(song),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No song found');
                      } else {
                        final artistNames = snapshot.data!;
                        return Container(
                          margin: const EdgeInsets.only(top: 2),
                          padding: const EdgeInsets.only( right: 1),
                          child: Text(
                            artistNames,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: TColor.primaryText60,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      }
                    },
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
