import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/common/color_extension.dart';
import '../../common_widget/title_selection_color.dart';
import '../../view_model/home_view_model.dart';

class SearchFoldersView extends StatefulWidget {
  const SearchFoldersView({super.key});

  @override
  State<SearchFoldersView> createState() => _SearchFoldersViewState();
}

class _SearchFoldersViewState extends State<SearchFoldersView> {
  final homeVM = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: TColor.bg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Đặt chiều cao tùy chỉnh cho AppBar
        child: AppBar(
          backgroundColor: TColor.bg,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 30.0,
            onPressed: () {
              Get.back();
            },
          ),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: TColor.bg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color:TColor.primaryText, // Màu sắc của border
                      width: 1.0, // Độ dày của border
                    ),
                  ),
                  child: TextField(

                    controller: homeVM.txtSearch.value,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,

                      hintText: "Tìm kiếm thư viện",
                      hintStyle: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 13,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 0), // Điều chỉnh padding ở đây

                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: TColor.primaryText,
                        ),
                        onPressed: () {
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/sort.png",
                    width: 17,
                    height: 13,
                  ),
                  const TitleSelectionColor(title: "Phát gần đây"),
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
                children: [
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
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "18 bài hát",
                          style: TextStyle(
                            color: TColor.primaryText60,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                children: [
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
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "18 bài hát",
                          style: TextStyle(
                            color: TColor.primaryText60,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Các widget khác của bạn
          ],
        ),
      ),

    );
  }
}
