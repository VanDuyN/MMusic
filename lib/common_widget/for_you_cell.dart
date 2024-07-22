import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/main_player_music_view/main_player_view.dart';

import 'package:mmusic/view_model/song_model.dart';


class ForYouCell extends StatelessWidget {
  final SongModel mObj;
  final SongHandler songHandler;

  const ForYouCell({super.key, required this.mObj, required this.songHandler});
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
    var url = API().getUrl();

    return Container(
        width: 182,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
        ),
        margin: const EdgeInsets.only(left: 15, top: 5, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                songHandler.initSongs(song: mObj);
                Get.to(() => MainPlayerView(
                  songHandler: songHandler,
                  isLast: false,
                  name: mObj.name,
                ));
              },
              child:ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.network(
                  url + mObj.image,
                  width: 182,
                  height: 182,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.only(left: 10, right: 1),
              child: Text(
                mObj.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: TColor.primaryText80,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FutureBuilder<String>(
              future: _getArtistNames(mObj),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No artists found');
                } else {
                  final artistNames = snapshot.data!;
                  return Container(
                    height: 15,
                    margin: const EdgeInsets.only(top: 2),
                    padding: const EdgeInsets.only(left: 10, right: 1),
                    child: Text(
                      artistNames,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: TColor.primaryText35,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
    );
  }
}

