import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:get/get.dart';
import 'package:mmusic/view_model/home_view_model.dart';
class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final homeVM = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      titleSpacing: 0.0,
      leadingWidth: 70,
      backgroundColor: TColor.primary20,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Image.asset(
          'assets/img/logo.png',
          width: 50,
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
      title:
      Container(
        margin: const EdgeInsets.only(left: 5),
        child: Text(
          "Tìm kiếm",
          style: TextStyle(
              color: TColor.primary,
              fontSize: 27,
              fontWeight: FontWeight.w900
          ),
        ),
      ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                TColor.primary20,
                Colors.transparent,
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Container(
               margin: const EdgeInsets.only(top: 30,left: 30,right: 40,bottom: 20),
                height: 50,
                  decoration: BoxDecoration(
                    color: TColor.primaryText,
                    borderRadius: BorderRadius.circular(19),
                  ),
                child: TextField(
                  controller: homeVM.txtSearch.value,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    prefixIcon: Container(
                      margin: const EdgeInsets.only(left: 10,bottom: 1,top: 1,right: 5),
                      alignment: Alignment.centerLeft,
                      width: 30,
                      child: Icon(
                        weight: 20,
                        Icons.search,
                        color: Colors.black.withOpacity(0.28),
                      ),
                    ),
                    hintText: "Nhập tên bài hát hoặc tên ca sĩ",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.28),
                      fontSize: 13,
                    )
                  ),
                ),
              ),
          ],
        )
      ),
    );
  }
}
