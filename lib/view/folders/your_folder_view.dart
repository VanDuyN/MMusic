import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:get/get.dart';
import 'package:mmusic/common_widget/your_folder_cell.dart';
import 'package:mmusic/common_widget/title_selection_color.dart';
import 'package:mmusic/view_model/home_view_model.dart';

class YourFolderView extends StatefulWidget {
  const YourFolderView({super.key});
  @override
  State<YourFolderView> createState() => _YourFolderState();
}

class _YourFolderState extends State<YourFolderView> {
  final homeVM = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: TColor.primary,
                        borderRadius: BorderRadius.circular(25)),
                    child: IconButton(
                      onPressed: () {},
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
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: TColor.primary,
                      borderRadius: BorderRadius.circular(25)),
                  child: IconButton(
                      onPressed: () {},
                      color: TColor.darkGray,
                      splashRadius: 26,
                      icon: Icon(
                        Icons.favorite_border,
                        size: 24,
                        color: TColor.bg,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Bài hát bạn yêu thích",
                    style: TextStyle(
                        color: TColor.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Bài hát bạn yêu thích",
                    style: TextStyle(
                        color: TColor.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  "assets/img/sort.png",
                  width: 20,
                  height: 20,
                ),
                const TitleSelectionColor(title: "Đã nghe gần đây")
              ],
            )
          ],
        ),
      ),
    );
  }
}
