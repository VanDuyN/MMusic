import 'package:flutter/material.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view_model/song_model.dart';
class SongsPlaylistCell extends StatelessWidget {
  final SongModel mObj;
  final SongHandler songHandler;
  final bool isArtist;
  const SongsPlaylistCell({super.key, required this.mObj, required this.songHandler, required this.isArtist});

  @override
  Widget build(BuildContext context) {
    String url = API().getUrl();
    return Container(
      width: double.maxFinite,
      padding:const EdgeInsets.all(1),
      margin:const EdgeInsets.only(left: 20,top: 10,right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.network(
              url + mObj.image,
              width: 60,
              height: 60,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin:const EdgeInsets.only(left: 10,top: 3,right: 1,bottom: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mObj.name,
                  style: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                ),),

                Text(isArtist ? "" : mObj.idArtist.toString(),
                  style: TextStyle(
                    color: TColor.primaryText60,
                    fontSize: 12,
                    fontWeight: FontWeight.w700
                ),),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: (){},
            icon:Icon(
              Icons.more_vert,
              color: TColor.primaryText,
            )),
        ],
      ),
    );
  }
}
