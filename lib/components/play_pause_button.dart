import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view_model/song_model.dart';
class PlayPauseButton extends StatelessWidget {
  final SongHandler songHandler;
  final double size;
  const PlayPauseButton({super.key, required this.songHandler, required this.size});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: songHandler.playbackState.stream,
      builder: (context, snapshot) {
        // Check if there's data in the snapshot
        if (snapshot.hasData) {
          // Retrieve the playing status from the playback state
          bool playing = snapshot.data!.playing;

          // Return an IconButton that toggles play/pause on press
          return Container(
            width: size*1.5,
            height: size*1.5,
            decoration: BoxDecoration(
              borderRadius:const  BorderRadius.all(Radius.circular(50)),
              gradient: LinearGradient(
                colors: [
                  TColor.primaryTopIcon,
                  TColor.primaryBottomIcon,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: IconButton(
              onPressed: () {
                // Toggle play/pause based on the current playing status
                if (playing) {
                  songHandler.pause();
                } else {
                  songHandler.play();
                }
              },
              // Display a play or pause icon based on the playing status
              icon: playing
                  ? Icon(Icons.pause_rounded, size: size,color: TColor.primaryText,)
                  : Icon(Icons.play_arrow_outlined, size: size,color: TColor.primaryText),
            ),
          );
        } else {
          // If there's no data in the snapshot, return an empty SizedBox
          return const SizedBox.shrink();
        }
      },
    );
  }
}