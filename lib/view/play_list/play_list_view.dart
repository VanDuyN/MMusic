import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:get/get.dart';
import 'package:mmusic/common_widget/songs_playlist_cell.dart';
import 'package:mmusic/view_model/home_view_model.dart';
class PlayListView extends StatefulWidget {
  const PlayListView({super.key});
  @override
  State<PlayListView> createState() => _PlayListViewState();
}
class _PlayListViewState extends State<PlayListView> {
  final homeVM = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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
            "PLAYLIST",
            style: TextStyle(
                color: TColor.primaryText80,
                fontSize: 20,
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
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset("assets/img/img_main1.png",width: 263,height: 252,),
              Text("lofi Loft", style: TextStyle(
                color: TColor.primaryText,
                fontSize: 34,
                fontWeight: FontWeight.w900
              ),),
              Text("soft, chill, dreamy, lo-fi beats",
                style: TextStyle(
                    color: TColor.primaryText60,
                    fontSize: 13,
                    fontWeight: FontWeight.w600
                ),),
              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.symmetric(vertical:8),
                  scrollDirection: Axis.vertical,
                  itemCount: 4,
                  itemBuilder: (context,index){
                    var mOBJ = homeVM.forYouListArr[index];
                    return ;//SongsPlaylistCell(mObj: mOBJ,);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
