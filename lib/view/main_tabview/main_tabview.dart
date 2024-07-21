import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/folders/folders_view.dart';
import 'package:mmusic/view/home/home_view.dart';
import 'package:mmusic/view/search/search_view.dart';
class MainTabview extends StatefulWidget{
  final SongHandler songHandler ;
  const MainTabview({super.key, required this.songHandler});
  @override
  State<MainTabview> createState() => _MainTabViewState();
}
class _MainTabViewState extends State<MainTabview> with SingleTickerProviderStateMixin{
  TabController? controller;
  int selectTab = 0;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller?.addListener((){
      selectTab = controller?.index ?? 0;
      setState(() {

      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(controller: controller,children: [
            HomeView(songHandler: widget.songHandler,),
            const SearchView(),
            FoldersView(songHandler: widget.songHandler,),
          ],
          ),
        ],
      ),

      bottomNavigationBar: Container(
        decoration:BoxDecoration(
            color: TColor.bg,
          boxShadow: const[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
        ]),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: TabBar(
            controller: controller,
            indicatorColor: Colors.transparent,
            indicatorWeight: 1,
            labelColor: TColor.primary,
            labelStyle: const TextStyle(fontSize: 10),
            unselectedLabelColor: TColor.primaryText28,
            unselectedLabelStyle: const TextStyle(fontSize: 10),
            tabs: [
              Tab(
                text: "Trang chủ",
                icon: Image.asset(
                    selectTab == 0
                        ? "assets/img/home_tab_un.png"
                        : "assets/img/home_tab.png",
                  width: 20,
                  height: 20,
                ),
              ),
              Tab(
                text: "Tìm kiếm",
                icon: Image.asset(
                  selectTab == 1
                      ? "assets/img/search_tab_un.png"
                      : "assets/img/search_tab.png",
                  width: 20,
                  height: 20,
                ),
              ),
              Tab(
                text: "Thư viện",
                icon: Image.asset(
                  selectTab == 2
                      ? "assets/img/folder_tab_un.png"
                      : "assets/img/folder_tab.png",
                  width: 20,
                  height: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}