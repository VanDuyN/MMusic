import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/components/play_pause_button.dart';
import 'package:mmusic/components/song_progress.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:flutter/material.dart';
import 'package:mmusic/view/main_player/main_player_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerDeck extends StatelessWidget {
  final SongHandler songHandler;
  final Function onTap;
  final bool isLast;

  // Constructor for the PlayerDeck class
  const PlayerDeck({
    super.key,
    required this.songHandler,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: songHandler.mediaItem.stream,
      builder: (context, snapshot) {
        MediaItem? playingSong = snapshot.data;
        // If there's no playing song, return an empty widget
        return playingSong == null
            ? const SizedBox.shrink()
            : _buildCard(context, playingSong);
      },
    );
  }
  Widget _buildCard(BuildContext context, MediaItem playingSong) {
    return Card(
      color: isLast ? TColor.bg : TColor.bg.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: isLast ? 0 : null,
      margin: const EdgeInsets.all(1.0),
      child: Stack(
        children: [
          // If not the last item, show artwork
          if (!isLast) _buildArtwork(playingSong),
          // If not the last item, overlay the artwork with a semi-transparent container
          if (!isLast) _buildArtworkOverlay(),
          // Build the content of the card
          _buildContent(context, playingSong),
        ],
      ),
    );
  }

  // Build the artwork widget
  Widget _buildArtwork(MediaItem playingSong) {
    return Positioned.fill(
      child: QueryArtworkWidget(
        // Set up artwork properties
        id: int.parse(playingSong.displayDescription!),
        type: ArtworkType.AUDIO,
        size: 1080,
        quality: 100,
        artworkHeight: 45,
        artworkWidth: 45,
        artworkBorder: BorderRadius.circular(16.0),
        nullArtworkWidget: Image.asset("assets/img/ic_launcher.png", width: 45,height: 45,),
      ),
    );
  }

  // Build the overlay for the artwork
  Widget _buildArtworkOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: TColor.bg.withOpacity(0.5),
        ),
      ),
    );
  }
  // Build the main content of the card
  Widget _buildContent(BuildContext context, MediaItem playingSong) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Build the title section
        _buildTitle(context, playingSong),
        // Build the song progress section
        _buildProgress(playingSong.duration!),
      ],
    );
  }
  // Build the title section
  Widget _buildTitle(BuildContext context, MediaItem playingSong) {
    return ListTile(
      onTap: () {
        // Handle tap on the title
        Get.to(MainPlayerView(songHandler: songHandler, isLast: isLast));
        int index = songHandler.queue.value.indexOf(playingSong);
        onTap(index);
      },
      tileColor: isLast ? Colors.transparent : null,
      leading: isLast
          ? null
          : DecoratedBox(
        // Leading widget with a decorated box or artwork
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: isLast
              ? Colors.transparent
              : TColor.bg,
        ),
        child: QueryArtworkWidget(
          // Artwork for the leading box
          id: int.parse(playingSong.displayDescription!),
          type: ArtworkType.AUDIO,
          size: 500,
          quality: 100,
          artworkBorder: BorderRadius.circular(8.0),
          errorBuilder: (p0, p1, p2) =>
          const Icon(Icons.music_note_rounded),
          nullArtworkWidget: Image.asset("assets/img/logo_app.png", width: 45,height: 45,),
        ),
      ),
      title: Text(
        isLast ? "" : playingSong.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: playingSong.artist == null
          ? null
          : Text(
        isLast ? "" : playingSong.artist!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: isLast
          ? null
          : SizedBox(
        // Trailing widget with song progress and play/pause button
        height: 50,
        width: 50,
        child: _buildTrailingWidget(context, playingSong),
      ),
    );
  }

  // Build the trailing widget with song progress and play/pause button
  Widget _buildTrailingWidget(BuildContext context, MediaItem playingSong) {
    return Stack(
      children: [
        StreamBuilder<Duration>(
          stream: AudioService.position,
          builder: (context, durationSnapshot) {
            if (durationSnapshot.hasData) {
              // Calculate and display song progress
              double progress = durationSnapshot.data!.inMilliseconds /
                  playingSong.duration!.inMilliseconds;
              return Center(
                child: CircularProgressIndicator(
                  strokeCap: StrokeCap.round,
                  strokeWidth: 3,
                  backgroundColor: isLast
                      ? Colors.transparent
                      : Theme.of(context).hoverColor,
                  value: progress,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        Center(
          // Play/Pause button
          child: PlayPauseButton(
            size: 30,
            songHandler: songHandler,
          ),
        ),
      ],
    );
  }

  // Build the song progress section
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
