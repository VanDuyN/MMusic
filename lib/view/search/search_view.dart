import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:get/get.dart';
import 'package:mmusic/common_widget/category_cell.dart';
import 'package:mmusic/common_widget/title_selection.dart';
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
              fontWeight: FontWeight.w700
          ),
        ),
      ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Center(
                 child: Container(
                   margin: const EdgeInsets.only(top: 30,left: 35,right: 40,bottom: 20),
                    height: 50,
                    alignment: Alignment.center,
                    transformAlignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: TColor.primaryText,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: homeVM.txtSearch.value,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(left: 20,bottom: 1,top: 1,right: 1),
                          alignment: Alignment.centerLeft,
                          width: 48,
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
               ),
              const TitleSelection(title: "Dành cho bạn"),
              SizedBox(
                height: 280,
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 110,),
                  itemCount: 4,
                  itemBuilder: (context,index){
                    var mOBJ = homeVM.categoryListArr[index];
                    return CategoryCell(mObj: mOBJ,);
                  },
                ),
              ),
              const TitleSelection(title: "Tất cả"),
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 110,),
                  itemCount: 6,
                  itemBuilder: (context,index){
                    var mOBJ = homeVM.categoryListArr[index];
                    return CategoryCell(mObj: mOBJ,);
                  },
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
