import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/common_widget/title_selection_color.dart';
import 'package:mmusic/common_widget/your_playlist_cell.dart';
import 'package:mmusic/view_model/home_view_model.dart';
class YourPlaylistView extends StatefulWidget {
  const YourPlaylistView({super.key});

  @override
  State<YourPlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<YourPlaylistView> {
  final homeVM = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 20,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            TColor.primaryTopIcon,
                            TColor.primaryBottomIcon,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: IconButton(
                      onPressed: (){},
                      splashRadius: 26,
                      icon: Icon(
                        Icons.add,
                        size: 24,
                        color: TColor.bg,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Thêm danh sách phát",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            TColor.primaryTopIcon,
                            TColor.primaryBottomIcon,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: IconButton(
                        onPressed: (){},
                        color: TColor.darkGray,
                        splashRadius: 26,
                        icon: Icon(
                          Icons.favorite_border,
                          size: 24,
                          color: TColor.bg,
                        )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Danh sách yêu thích",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top:20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/sort.png",
                    width: 17,
                    height: 13,),
                  const TitleSelectionColor(title: "Danh sách phát gần đây")
                ],
              ),
            ),
            SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.symmetric(vertical:8),
                scrollDirection: Axis.vertical,
                itemCount: 4,
                itemBuilder: (context,index){
                  var mOBJ = homeVM.yourPlayListArr[index];
                  return;// YourPlaylistCell(mObj: mOBJ,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
