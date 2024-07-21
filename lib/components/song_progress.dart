import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
class SongProgress extends StatelessWidget {
  final Duration totalDuration;
  final SongHandler songHandler;
  final bool isPlayDeck;
  const SongProgress({
    super.key,
    required this.totalDuration,
    required this.songHandler,
    required this.isPlayDeck

  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: AudioService.position,
      builder: (context, positionSnapshot) {
        // Retrieve the current position from the stream
        Duration? position = positionSnapshot.data;

        // Check if position is null and provide a default value if necessary
        Duration safePosition = position ?? Duration.zero;

        // Display the appropriate ProgressBar widget
        return isPlayDeck ? _buildPlayDeck(safePosition) : _buildNoPlayDeck(safePosition);
      },
    );
  }

  Widget _buildPlayDeck(Duration position) {
    return ProgressBar(
      progress: position,
      total: totalDuration,
      onSeek: (position) {
        songHandler.seek(position);
      },
      barHeight: 6,
      thumbRadius: 6,
      thumbGlowRadius: 8,
      timeLabelLocation: TimeLabelLocation.below,
      timeLabelPadding: 10,
      thumbColor: TColor.primary,
      thumbGlowColor: TColor.primary,
    );
  }

  Widget _buildNoPlayDeck(Duration position) {
     return Container(
       color: TColor.bg.withOpacity(0),
       height: 2, // Ensure the parent Container has a height
       child: FractionallySizedBox(
         heightFactor: 0.1, // Display 50% height of its parent
         child: ProgressBar(
           progress: position,
           total: totalDuration,
           onSeek: (position) {
             songHandler.seek(position);
           },
           barHeight: 6,
           thumbRadius: 0,
           thumbGlowRadius: 0,
           timeLabelLocation: TimeLabelLocation.none,
           thumbColor: TColor.primary,
           thumbGlowColor: TColor.primary,
         ),
       ),
     );
  }
}