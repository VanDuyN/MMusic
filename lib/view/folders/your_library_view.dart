import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/common_widget/your_library_cell.dart';
import 'package:mmusic/common_widget/title_selection_color.dart';
import 'package:mmusic/view_model/home_view_model.dart';
class YourLibraryView extends StatefulWidget {
  const YourLibraryView({super.key});

  @override
  State<YourLibraryView> createState() => _YourFolderViewState();
}

class _YourFolderViewState extends State<YourLibraryView> {
  final homeVM = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 10,right: 5),
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
                      "Bài hát bạn yêu thích",
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
                  const TitleSelectionColor(title: "Danh sách nghe gần đây")
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 43,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/img/img_19.png",
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Sơn tùng MTP",
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                children:[
                   Image.asset(
                      "assets/img/img_1.png",
                      width: 84,
                      height: 84,
                      fit: BoxFit.fill,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Cà phê quán quen",
                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 20,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        Text(
                          "18 bài hát",
                          style: TextStyle(
                              color: TColor.primaryText60,
                              fontSize: 15,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  var mOBJ = homeVM.forYouListArr[index];
                  return LibraryCell(mObj: mOBJ,);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                children:[
                  Image.asset(
                    "assets/img/img_7.png",
                    width: 84,
                    height: 84,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          " Bài hát bạn đã thích",
                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 20,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        Text(
                          "80 bài hát",
                          style: TextStyle(
                              color: TColor.primaryText60,
                              fontSize: 15,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
