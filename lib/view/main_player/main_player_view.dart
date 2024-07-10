import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/components/player_button.dart';
import 'package:mmusic/components/song_progress.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:mmusic/common/color_extension.dart';
class MainPlayerView extends StatelessWidget {
  final bool isLast;
  final SongHandler songHandler;
  const MainPlayerView({super.key, required this.songHandler, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: TColor.bg,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_sharp,
                weight: 28,
              ),
            ),
            title: Center(
              child: Text(
                " Em của ngày hôm qua",
                style: TextStyle(
                    color: TColor.primaryText80,
                    fontSize: 12,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    weight: 24,
                  )),
              )
            ],
          ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<MediaItem?>(
            stream: songHandler.mediaItem.stream,
            builder: (context, snapshot) {
              MediaItem? playingSong = snapshot.data;
              // If there's no playing song, return an empty widget
              return playingSong == null
                  ? const SizedBox.shrink()
                  : _buildPlayer(context, playingSong);
            },
        ),
      ),
    );
  }
  Widget _buildPlayer(BuildContext context, MediaItem playingSong){
    return SingleChildScrollView(
      child: Column(
        children: [
          if (!isLast) _buildArtwork(playingSong),
          // If not the last item, overlay the artwork with a semi-transparent container
          //if (!isLast) _buildArtworkOverlay(),
          _buildContent(context, playingSong),
          _buildLyrics(context,playingSong),
        ],
      ),
    );
  }
  Widget _buildLyrics(BuildContext context,MediaItem playingSong){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text("Lời", style:TextStyle(
              color: TColor.primaryText60,
              fontWeight: FontWeight.w700,
              fontSize: 18
            ),),
          ),
          Container(
            width: double.maxFinite,
            margin:const EdgeInsets.all(10),
            padding:const EdgeInsets.all(15),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    TColor.primaryTopIcon,
                    TColor.primaryBottomIcon,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(25)
            ),
            child: Text(
              "Đang được cập nhật",
              style: TextStyle(
                color: TColor.primaryText,
                fontWeight: FontWeight.w600,
                fontSize: 20
            ),
            ),
          )
        ],
    );
  }
  Widget _buildArtwork(MediaItem playingSong) {
    return Positioned.fill(
      child: QueryArtworkWidget(
        // Set up artwork properties
        id: int.parse(playingSong.displayDescription!),
        type: ArtworkType.AUDIO,
        size: 1080,
        quality: 100,
        artworkHeight: 345,
        artworkWidth: 330,
        artworkBorder: BorderRadius.circular(16.0),
        nullArtworkWidget:  Image.asset("assets/img/logo_app.png",width: 330,height: 345,),
      ),
    );
  }
  Widget _buildContent(BuildContext context, MediaItem playingSong) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Build the title section
        _buildTitle(context, playingSong),
        // Build the song progress section
        _buildProgress(playingSong.duration!),
        _buildTrailingWidget(context, playingSong)
      ],
    );
  }
  Widget _buildTitle (BuildContext context, MediaItem playingSong){
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20,right: 10,bottom: 10),
      child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isLast ? "" : playingSong.title,
            maxLines: 1,
            style: TextStyle(
              color: TColor.primaryText,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            isLast ? "" : playingSong.artist!,
            maxLines: 1,
            style: TextStyle(
              color: TColor.primaryText60,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  Widget _buildTrailingWidget(BuildContext context, MediaItem playingSong) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PlayerButton(songHandler: songHandler)
      ],
    );
  }
  Widget _buildProgress(Duration totalDuration) {
    return ListTile(
      title: isLast
          ? null
          : SongProgress(
        // Use SongProgress widget to display progress bar
          totalDuration: totalDuration,
          songHandler: songHandler),
    );
  }
}


