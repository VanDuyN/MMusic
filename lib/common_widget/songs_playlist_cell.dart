import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:get/get.dart';
import 'package:mmusic/view/main_player_music_view/main_player_view.dart';
class SongsPlaylistCell extends StatelessWidget {
  final MediaItem mObj;
  final SongHandler songHandler;
  final bool isArtist;
  final List<MediaItem> songs;
  final int index;
  const SongsPlaylistCell({
    super.key,
    required this.mObj,
    required this.songHandler,
    required this.isArtist,
    required this.songs, required this.index});

  @override
  Widget build(BuildContext context) {
    MediaItem song= mObj;
    return StreamBuilder<MediaItem?>(
      stream: songHandler.mediaItem.stream,
      builder: (context, snapshot) {
        MediaItem? playingSong = snapshot.data;
        return index == (songs.length - 1)
            ? _buildLastSongItem(song,playingSong)
            :_buildRegularSongItem(song,playingSong);
      }
    );
  }
  Widget _buildLastSongItem(MediaItem song,MediaItem? playing){
    return InkWell(
      onTap: ()async{
        await songHandler.skipToQueueItem(songs.length - 1);
        Get.to(MainPlayerView(songHandler: songHandler,isLast: false,name: playing!.title,));
      },
      child: Container(
        width: double.maxFinite,
        padding:const EdgeInsets.all(1),
        margin:const EdgeInsets.only(top: 10,right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.network(
                mObj.artUri.toString(),
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
                  Text(mObj.title,
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                    ),),
                  Text(isArtist ? "" : mObj.artist.toString(),
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
      ),
    );
  }
  Widget _buildRegularSongItem(MediaItem song,MediaItem? playing){
    return InkWell(
      onTap: ()async{
        await songHandler.skipToQueueItem(songs.indexOf(song));
        Get.to(
            MainPlayerView(
              songHandler: songHandler,
              isLast: false,
              name: playing!.artist.toString(),)
        );
      },
      child: Container(
        width: double.maxFinite,
        padding:const EdgeInsets.all(1),
        margin:const EdgeInsets.only(top: 10,right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.network(
                mObj.artUri.toString(),
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
                  Container(
                    child: Text(mObj.title,
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                      ),),
                  ),
                  Text(isArtist ? "" : mObj.artist.toString(),
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
      ),
    );
  }
}

