import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/components/player_deck.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/folders/albums_view.dart';
import 'package:mmusic/view/folders/your_artist_view.dart';
import 'package:mmusic/view/folders/your_folder_view.dart';
import 'package:mmusic/view/folders/your_library_view.dart';
import 'package:mmusic/view/folders/your_playlist_view.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
class FoldersView extends StatefulWidget {
  final SongHandler songHandler;
  const FoldersView({super.key, required this.songHandler});

  @override
  State<FoldersView> createState() => _FoldersViewState();
}

class _FoldersViewState extends State<FoldersView> with SingleTickerProviderStateMixin {

  final AutoScrollController _autoScrollController = AutoScrollController();
  void _scrollTo(int index) {
    _autoScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
      duration: const Duration(milliseconds: 800),
    );
  }
  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length:  5, vsync: this);
    controller?.addListener((){
      selectTab = controller?.index?? 0;
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 5),
          child: Image.asset(
            'assets/img/logo_app.png',
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
        title:
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              "Thư viện của bạn",
              style: TextStyle(
                color: TColor.primaryTextM,
                fontSize: 27,
                fontWeight: FontWeight.w900
              ),
            ),
          ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.search,
                  size: 30,
                  color: TColor.primaryText60,
                  )
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(
              height: kToolbarHeight,
              child: TabBar(controller: controller,
                isScrollable: true,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                labelStyle: TextStyle(color:
                    TColor.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(color:
                TColor.primaryText80,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
                unselectedLabelColor: TColor.primaryText,
                indicator: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0),
                  border:Border.all(color: TColor.primary,width: 2),
                ),
                tabs: const [
                Tab(
                  text: "Thư viện",
                ),
                Tab(
                  text: "Thư mục",
                ),
                Tab(
                  text: "Danh sách",
                ),
                Tab(
                  text: "Nghệ sĩ",
                ),
                Tab(
                  text: "Albums",
                ),
              ],),
            ),
            Expanded(child:TabBarView(
              controller: controller,
              children: [
                YourLibraryView(songHandler: widget.songHandler,),
                YourFolderView(songHandler: widget.songHandler,),
                const YourPlaylistView(),
                const YourArtistView(),
                const AlbumsView(),
              ]
            )
            ),
          ],),
          _buildPlayerDeck(),
        ],
      ),
    );
  }
  Widget _buildPlayerDeck() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // PlayerDeck widget with controls and the ability to scroll to a specific song
        PlayerDeck(
          songHandler: widget.songHandler,
          isLast: false,
          onTap: _scrollTo,
        ),
      ],
    );
  }
}

