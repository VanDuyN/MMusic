import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/common_widget/artist_cell.dart';
import 'package:mmusic/common_widget/continue_cell.dart';
import 'package:mmusic/common_widget/for_you_cell.dart';
import 'package:mmusic/common_widget/recently_cell.dart';
import 'package:mmusic/common_widget/title_selection.dart';
import 'package:mmusic/components/player_deck.dart';
import 'package:mmusic/notifiers/song_provider.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/login/login_view.dart';
import 'package:mmusic/view/my_profile/my_profile_view.dart';
import 'package:mmusic/view_model/home_view_model.dart';
import 'package:mmusic/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
class HomeView extends StatefulWidget {
  final SongHandler songHandler;
  const HomeView({super.key, required this.songHandler});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AutoScrollController _autoScrollController = AutoScrollController();
  void _scrollTo(int index) {
    _autoScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
      duration: const Duration(milliseconds: 800),
    );
  }
  final homeVM = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    var splashVM= Get.find<SplashViewModel>();
    return Scaffold(
      key: splashVM.scaffoldKey,
      drawer: Drawer(
        backgroundColor: TColor.bg,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 260,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: TColor.primaryText.withOpacity(0.07),
                ),
                child: Column(
                children: [
                  Image.asset(
                    "assets/img/logo_app.png",
                    width: media.width*0.35,
                  ),
                  const SizedBox(height: 10,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                      Column(
                        children: [
                          Text(
                            "328\nSongs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xffC1C0C0),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "52\nAlbums",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xffC1C0C0),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "87\nArtists",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xffC1C0C0),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                  ],)
                ],
              ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: TColor.primary,
                size: 24,
              ),
              title: Text(
                "Thông tin cá nhân",
                style: TextStyle(
                  color: TColor.primaryText.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: (){
                Get.off(const MyProfileView());
              },
            ),
            Divider(
              color: TColor.primary.withOpacity(0.3),
              indent: 70,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: TColor.primary,
                size: 24,
              ),
              title: Text(
                "Thông tin cá nhân",
                style: TextStyle(
                  color: TColor.primaryText.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: (){
                splashVM.closeDrawer();
              },
            ),
            Divider(
              color: TColor.primary.withOpacity(0.3),
              indent: 70,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: TColor.primary,
                size: 24,
              ),
              title: Text(
                "Thông tin cá nhân",
                style: TextStyle(
                  color: TColor.primaryText.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: (){
                splashVM.closeDrawer();
              },
            ),
            Divider(
              color: TColor.primary.withOpacity(0.3),
              indent: 70,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: TColor.primary,
                size: 24,
              ),
              title: Text(
                "Đăng xuất",
                style: TextStyle(
                  color: TColor.primaryText.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: (){
                  Get.to(()=> LoginView(songHandler: widget.songHandler,));
                splashVM.closeDrawer();

              },
            ),
            Divider(
              color: TColor.primaryText.withOpacity(0.3),
              indent: 70,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        titleSpacing: 0.0,
        leadingWidth: 70,
        backgroundColor: TColor.primary30,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.find<SplashViewModel>().openDrawer();
            },
            icon: CircleAvatar(
              radius: 49,
              backgroundColor: TColor.primary,
              child: Padding(
                padding: const EdgeInsets.all(5), // Border radius
                child: ClipOval(
                  child: Image.asset(
                    'assets/img/user.png',
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("Chào mừng quay chở lại !",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 15,
            fontWeight: FontWeight.w600
          ),),
          Text("mmusic",
          style: TextStyle(
            color: TColor.primaryText60,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),)
        ],),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Image.asset(
                      'assets/img/vector_tab.png',
                      width: 25,
                      height: 25,
                      fit: BoxFit.contain,)
          ),
          IconButton(
              onPressed: (){},
              icon: Image.asset(
                'assets/img/bell_tab.png',
                width: 25,
                height: 25,
                fit: BoxFit.contain,)
          ),
          IconButton(
              onPressed: (){},
              icon: Image.asset(
                'assets/img/setting_tab.png',
                width: 25,
                height: 25,
                fit: BoxFit.contain,)
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              TColor.primary30,
              Colors.transparent,
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child:Stack(
          children: [

            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleSelection(title: "Tiếp tục nghe"),
                  SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.only(left: 15, right: 5),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                        mainAxisExtent: 83,),
                      itemCount: 6,
                      itemBuilder: (context,index){
                        var mOBJ = homeVM.continueListeningArr[index];
                        return ContinueCell(mObj: mOBJ,);
                      },
                    ),
                  ),
                  const TitleSelection(title: "Nghe gần đây"),
                  SizedBox(
                    height: 162,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal:8),
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context,index){
                        var mOBJ = homeVM.recentlyListArr[index];
                        return RecentlyCell(mObj: mOBJ,);
                      },
                    ),
                  ),
                  const TitleSelection(title: "Dành cho bạn"),
                  Consumer<SongsProvider>(
                    builder: (context, songsProvider,child) {
                    return  songsProvider.isLoading
                        ? _buildLoadingIndicator() // Display a loading indicator while songs are loading
                        : _buildSongsList(songsProvider);
                    },
                  ),
                  SizedBox(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context,index){
                        var mOBJ = homeVM.forYouListArr[index];
                        return ForYouCell(mObj: mOBJ,);
                      },
                    ),
                  ),
                  const TitleSelection(title: "Nghệ sĩ"),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      padding:const EdgeInsets.only(left: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context,index){
                        var mOBJ = homeVM.artistListArr[index];
                        return ArtistCell(mObj: mOBJ,);
                      },
                    ),
                  ),
                  PlayerDeck(
                    songHandler: widget.songHandler,
                    isLast: true,
                    onTap: () {},
                  ),
                ],),
            ),
            _buildPlayerDeck(),
          ],
        ),
      )
    );
  }
  Widget _buildLoadingIndicator(){
    return const Center(
      child: CircularProgressIndicator(
        strokeCap: StrokeCap.round,
      ),
    );
  }
  Widget _buildSongsList(SongsProvider songsProvider) {
    return Stack(
      children: [
        // SongsList widget to display the list of songs
        // ForYouList(
        //   songHandler: widget.songHandler,
        //   songs: songsProvider.songs,
        //   autoScrollController: _autoScrollController,
        // ),
        //_buildPlayerDeck(), // PlayerDeck widget for music playback controls
      ],
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
