import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/components/play_pause_button.dart';
import 'package:mmusic/components/song_progress.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/main_player_music_view/main_player_view.dart';

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
    return Stack(
        children: [
          // If not the last item, show artwork
          if (!isLast) _buildArtwork(playingSong),
          // If not the last item, overlay the artwork with a semi-transparent container
          if (!isLast) _buildArtworkOverlay(),
          // Build the content of the card
          _buildContent(context, playingSong),
        ],
    );
  }

  // Build the artwork widget
  Widget _buildArtwork(MediaItem playingSong) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(0),  // Border radius ở góc trên trái
        topRight: Radius.circular(0), // Border radius ở góc trên phải
        bottomLeft: Radius.zero,      // Không có border radius ở góc dưới trái
        bottomRight: Radius.zero,     // Không có border radius ở góc dưới phải
      ),
      child: Image.network(
        playingSong.artUri.toString(),
        fit: BoxFit.cover,
        width: double.maxFinite, // Sử dụng double.infinity để chiếm hết chiều rộng có sẵn
        height: 80,
      ),
    );
  }

  // Build the overlay for the artwork
  Widget _buildArtworkOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: TColor.bg.withOpacity(0.5),
        ),
      ),
    );
  }

  // Build the main content of the card
  Widget _buildContent(BuildContext context, MediaItem playingSong) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitle(context, playingSong),
        _buildProgress(playingSong.duration!),
      ],
    );
  }

  // Build the title section
  Widget _buildTitle(BuildContext context, MediaItem playingSong) {
    return ListTile(
      onTap: () {
        // Handle tap on the title
        Get.to(MainPlayerView(
          songHandler: songHandler,
          isLast: isLast,
          name: playingSong.title,
        ));
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
          color: isLast ? Colors.transparent : TColor.bg,
        ),
        child: Image.network(
          playingSong.artUri.toString(),
          fit: BoxFit.cover,
          width: 60,
          height: 60,
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
    return Center(
      // Play/Pause button
      child: PlayPauseButton(
        size: 30,
        songHandler: songHandler,
      ),
    );
  }
  // Build the song progress section
  Widget _buildProgress(Duration totalDuration) {
    return isLast
        ? const SizedBox.shrink()
        : SongProgress(
      // Use SongProgress widget to display progress bar
      totalDuration: totalDuration,
      songHandler: songHandler,
      isPlayDeck: false,
    );
  }
}
