import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/components/player_button.dart';
import 'package:mmusic/components/song_progress.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/view_model/home_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MainPlayerView extends StatefulWidget {
  final bool isLast;
  final SongHandler songHandler;
  final String name;

  const MainPlayerView({
    super.key,
    required this.songHandler,
    required this.isLast,
    required this.name
  });

  @override
  _MainPlayerViewState createState() => _MainPlayerViewState();
}

class _MainPlayerViewState extends State<MainPlayerView> {
  bool _isFavourite = false;
  String _userEmail = '';
  DateTime? _lastPressedTime;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final email = await _checkUser();
    setState(() {
      _userEmail = email ?? '';
    });
  }

  Future<String?> _checkUser() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString('token');
      if (token == null) return null;
      Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(token);
      setState(() {

      });
      return jwtDecodeToken['email'] as String?;
    } catch (e) {
      setState(() {

      });
      print('Error decoding token: $e');
      return null;
    }
  }

  Future<void> _updateFavouriteStatus(MediaItem playingSong) async {
    final isFavourite = await HomeViewModel().checkFavourite(playingSong.displayDescription.toString(), _userEmail);
    setState(() {
      _isFavourite = isFavourite;
    });
  }

  void _onFavouriteButtonPressed(MediaItem playingSong) {
    final now = DateTime.now();
    if (_lastPressedTime != null && now.difference(_lastPressedTime!) < const Duration(seconds: 2)) {
      return;
    }
    _lastPressedTime = now;

    if (_userEmail.isNotEmpty) {
      if (_isFavourite) {
        API().deleteFavourite(playingSong.displayDescription.toString(), _userEmail);
        setState(() {
          _isFavourite = false;
        });
      } else {
        API().addFavourite(playingSong.displayDescription.toString(), _userEmail);
        setState(() {
          _isFavourite = true;
        });
      }
    }
  }

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
            widget.name,
            style: TextStyle(
              color: TColor.primaryText80,
              fontSize: 12,
              fontWeight: FontWeight.w600,
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
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<MediaItem?>(
          stream: widget.songHandler.mediaItem.stream,
          builder: (context, snapshot) {
            MediaItem? playingSong = snapshot.data;
            if (playingSong == null) {
              return const SizedBox.shrink();
            }

            _updateFavouriteStatus(playingSong);

            return SingleChildScrollView(
              child: Column(
                children: [
                  if (!widget.isLast) _buildArtwork(playingSong),
                  _buildContent(context, playingSong),
                  _buildLyrics(context, playingSong),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLyrics(BuildContext context, MediaItem playingSong) {
    return FutureBuilder<String?>(
      future: _checkUser(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          const Center(child: CircularProgressIndicator());
        } else if (userSnapshot.hasError) {
           const Center(child: Text('Lỗi khi lấy thông tin người dùng'));
        }

        final userEmail = userSnapshot.data;
        if (userEmail == null) {
          return const Center(child: Text('Người dùng không đăng nhập'));
        }
        return FutureBuilder<bool>(
          future: HomeViewModel().checkFavourite(playingSong.displayDescription.toString(), userEmail),
          builder: (context, favouriteSnapshot) {
            if (favouriteSnapshot.connectionState == ConnectionState.waiting) {
              const Center(child: CircularProgressIndicator());
            } else if (favouriteSnapshot.hasError) {
              const Center(child: Text('Lỗi khi kiểm tra yêu thích'));
            }
            final isFavourite = favouriteSnapshot.data ?? false;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Lời", style: TextStyle(
                        color: TColor.primaryText60,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {
                          _onFavouriteButtonPressed(playingSong);
                        },
                        icon: Icon(
                          size: 30,
                          isFavourite ? Icons.favorite : Icons.favorite_outline,
                          color: TColor.primaryBottomIcon,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        TColor.primaryBottomIcon,
                        TColor.primary,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    playingSong.displaySubtitle.toString(),
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildArtwork(MediaItem playingSong) {
    return Image.network(
      playingSong.artUri.toString(),
      height: 345,
      width: 330,
      fit: BoxFit.contain,
    );
  }

  Widget _buildContent(BuildContext context, MediaItem playingSong) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTitle(context, playingSong),
        _buildProgress(playingSong.duration!),
        _buildTrailingWidget(context, playingSong),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, MediaItem playingSong) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isLast ? "" : playingSong.title,
            maxLines: 1,
            style: TextStyle(
              color: TColor.primaryText,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.isLast ? "" : playingSong.artist!,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PlayerButton(songHandler: widget.songHandler),
      ],
    );
  }

  Widget _buildProgress(Duration totalDuration) {
    return ListTile(
      title: widget.isLast
          ? null
          : SongProgress(
        totalDuration: totalDuration,
        songHandler: widget.songHandler,
        isPlayDeck: true,
      ),
    );
  }
}
