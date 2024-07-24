import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/common_widget/artist_cell.dart';
import 'package:mmusic/common_widget/continue_cell.dart';
import 'package:mmusic/common_widget/for_you_cell.dart';
import 'package:mmusic/common_widget/recently_cell.dart';
import 'package:mmusic/common_widget/title_selection.dart';
import 'package:mmusic/components/player_deck.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/Settings/Setting_view.dart';
import 'package:mmusic/view/login/login_view.dart';
import 'package:mmusic/view/notifications/notification_view.dart';
import 'package:mmusic/view/profile/my_profile_view.dart';
import 'package:mmusic/view_model/album_model.dart';
import 'package:mmusic/view_model/arist_model.dart';
import 'package:mmusic/view_model/category_model.dart';
import 'package:mmusic/view_model/home_view_model.dart';
import 'package:mmusic/view_model/song_model.dart';
import 'package:mmusic/view_model/splash_view_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeView extends StatefulWidget {
  final SongHandler songHandler;
  const HomeView({super.key, required this.songHandler});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AutoScrollController _autoScrollController = AutoScrollController();
  final homeVM = Get.put(HomeViewModel());
  late final SharedPreferences prefs;
  late bool isCheckUser = false;
  late String linkImg ="";
  late String emailUser = "";
  late String name = "";
  late Map<String,dynamic> jwtDecodeToken;

  void _scrollTo(int index) {
    _autoScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
      duration: const Duration(milliseconds: 800),
    );
  }
  void getImage(String email) async{

    var  jsonResponse =jsonDecode(await API().getUser(email));
    var url =  API().getUrl();
    linkImg = url + jsonResponse['data']['image'];
    name = jsonResponse['data']['name'];
    emailUser = email;
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }
  void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
    jwtDecodeToken = JwtDecoder.decode(prefs.getString('token')!);
    setState(() {
      prefs.getString('token') != null ? isCheckUser = true : isCheckUser = false;
      isCheckUser
        ? getImage(jwtDecodeToken['email'])
        :const SizedBox();
    });

  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    var splashVM = Get.find<SplashViewModel>();
    final Future<List<Artist>> artistArr = HomeViewModel().getDataArist();
    final Future<List<SongModel>> songArr = HomeViewModel().getDataSong();
    final Future<List<CategoryModel>> categoriesArr = HomeViewModel().getAllCategory();
    final Future<List<AlbumModel>> albumArr = HomeViewModel().getAllAlbum();

    return Scaffold(
      key: splashVM.scaffoldKey,
      drawer: _buildDrawer(media, splashVM),
      appBar: AppBar(
        titleSpacing: 0.0,
        leadingWidth: 70,
        backgroundColor: TColor.primary30,
        elevation: 0,
        leading: _buildLeading(),
        title: _buildTitle(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/img/vector_tab.png',
                width: 25,
                height: 25,
                fit: BoxFit.contain,)
          ),
          IconButton(
              onPressed: () {
                Get.to(const NotificationView());
              },
              icon: Image.asset(
                'assets/img/bell_tab.png',
                width: 25,
                height: 25,
                fit: BoxFit.contain,)
          ),
          IconButton(
              onPressed: () {
                Get.to(const SettingView());
              },
              icon: Image.asset(
                'assets/img/setting_tab.png',
                width: 25,
                height: 25,
                fit: BoxFit.contain,)
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25,),
                  const TitleSelection(title: "Album nghe nhiều"),
                  const SizedBox(height: 5,),
                  _buildAlbum(context,albumArr),

                  const SizedBox(height: 20,),

                  const TitleSelection(title: "Thể loại đề xuất"),

                  _buildCategories(context,categoriesArr),
                  const  SizedBox(height: 20,),
                  const TitleSelection(title: "Dành cho bạn"),
                  const SizedBox(height: 10,),

                  _buildSongs(context,songArr),

                  const TitleSelection(title: "Nghệ sĩ"),

                  _buildArtist(context, artistArr),

                   PlayerDeck(songHandler: widget.songHandler, isLast: true, onTap: () {},),

                ],
              ),
            ),
            _buildPlayerDeck(),
          ],
        ),
      ),
    );
  }
  Widget _buildTitle(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Chào mừng quay trở lại !!!",
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
      ],
    );
  }
  Widget _buildDrawer(var media ,var splashVM){
    return Drawer(
      backgroundColor: TColor.bg,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 280,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: TColor.primaryText.withOpacity(0.07),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/img/logo_app.png",
                    width: media.width * 0.30,
                  ),
                  const SizedBox(height: 5,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "328\nSongs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xffC1C0C0),
                              fontSize: 13,
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
          !isCheckUser
              ? ListTile(
            leading: Icon(
              Icons.person,
              color: TColor.primary,
              size: 24,
            ),
            title: Text(
              "Đăng nhập",
              style: TextStyle(
                color: TColor.primaryText.withOpacity(0.9),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Get.to(() => LoginView(songHandler: widget.songHandler,));
              splashVM.closeDrawer();
            },
          ) :
          Column(
            children: [
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
                  onTap: () {
                    Get.to( MyProfileView(email: emailUser,img: linkImg,name: name,));
                    splashVM.closeDrawer();

                  }
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
                onTap: () {
                  Get.to(() => LoginView(songHandler: widget.songHandler,));
                  prefs.remove('token');
                  isCheckUser == false;
                  setState(() {
                  });
                  splashVM.closeDrawer();
                },
              ),
              Divider(
                color: TColor.primaryText.withOpacity(0.3),
                indent: 70,
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildLeading(){
    return  IconButton(
      onPressed: () {
        Get.find<SplashViewModel>().openDrawer();
      },
      icon: CircleAvatar(
        radius: 49,
        backgroundColor: TColor.primary,
        child: Padding(
          padding: const EdgeInsets.all(5), // Border radius
          child: ClipOval(
            child: Image.network(
                linkImg,
                width: 35,
                height: 35,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Image.asset(
                      "assets/img/logo_app.png",
                      width: 80,
                      height: 80,
                      color: TColor.primaryText,
                      fit: BoxFit.cover
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildPlayerDeck() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PlayerDeck(
            songHandler: widget.songHandler,
            isLast: false,
            onTap: _scrollTo,
          ),
        ]
    );
  }

  Widget _buildAlbum(BuildContext context, Future<List<AlbumModel>> albumArr) {
    return SizedBox(
      height: 250,
      child: FutureBuilder<List<AlbumModel>>(
        future: albumArr,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Đã xảy ra lỗi'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có dữ liệu album'));
          }
          final albums = snapshot.data!;
          return GridView.builder(
            key: const PageStorageKey('album'),
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.only(left: 15, right: 5),
            physics: const NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              mainAxisExtent: 83,
            ),
            itemCount: albums.length >= 6 ? 6 : albums.length,
            itemBuilder: (context, index) {
              return ContinueCell(
                album: albums[index],
                songHandler: widget.songHandler,
              );
            },
          );
        },
      ),
    );
  }


  Widget _buildCategories(BuildContext context, final Future<List<CategoryModel>> categoriesArr){
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<CategoryModel>>(
        future: categoriesArr,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            final categories = snapshot.data!;
            return  ListView.builder(
              key:const  PageStorageKey('categories'),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length >= 10 ? 10 : categories.length,
              itemBuilder: (context, index) {
                return RecentlyCell(category: categories[index], songHandler: widget.songHandler);
              },

            );
          }
        },
      ),
    );
  }
  
  Widget _buildSongs(BuildContext context,Future<List<SongModel>> songArr){
    return SizedBox(
      height: 250,
      child: FutureBuilder<List<SongModel>>(
        future: songArr,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            final songs = snapshot.data!;
            return ListView.builder(
              key: const PageStorageKey('song'),
              padding: const EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              itemCount: songs.length >= 20 ? 20 : songs.length,
              itemBuilder: (context, index) {
                return ForYouCell(mObj: songs[index], songHandler: widget.songHandler);
              },
            );
          }
        },
      ),
    );
  }
  Widget _buildArtist(BuildContext context, Future<List<Artist>> artistArr){
    return SizedBox(
      height: 220,
      child: FutureBuilder<List<Artist>>(
        future: artistArr,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            List<Artist> artists = snapshot.data!;
            return ListView.builder(
              key:const PageStorageKey('artist'),
              padding: const EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              itemCount: artists.length > 10 ? 10 : artists.length,
              itemBuilder: (context, index) {
                Artist artist = artists[index];
                return ArtistCell(mObj: artist,songHandler: widget.songHandler,);
              },
            );
          }
        },
      ),
    );
  }
}
