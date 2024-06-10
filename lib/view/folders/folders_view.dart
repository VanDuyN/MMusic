import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:get/get.dart';
import '../../view_model/splash_view_model.dart';
class FoldersView extends StatefulWidget {
  const FoldersView({super.key});

  @override
  State<FoldersView> createState() => _FoldersViewState();
}

class _FoldersViewState extends State<FoldersView> with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length:  4, vsync: this);
    controller?.addListener((){
      selectTab = controller?.index?? 0;
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
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
              "Thư viện của bạn",
              style: TextStyle(
                color: TColor.primary,
                fontSize: 27,
                fontWeight: FontWeight.w900
              ),
            ),
          ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.search,
                  size: 30,
                  color: TColor.primaryText60,
                  )
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        SizedBox(
          height: kToolbarHeight,
          child: TabBar(controller: controller,
            isScrollable: true,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
            labelStyle: TextStyle(color:
                TColor.primary,
                fontSize: 15,
                fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(color:
            TColor.primaryText80,
                fontSize: 15,
                fontWeight: FontWeight.w600),
            unselectedLabelColor: TColor.primaryText,
            indicator: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.0),
              border:Border.all(color: TColor.primary,width: 2),

            ),
            tabs: const [
            Tab(
              text: "Thư mục",
            ),
            Tab(
              text: "Danh sách",
            ),
            Tab(
              text: "Nghệ sĩ",
            ),
            Tab(
              text: "Albums",
            ),
          ],),
        ),
        Expanded(child:TabBarView(
          controller: controller,
          children: const [
            Center(child: Text("Thư mục"),),
            Center(child: Text("Thư mục"),),
            Center(child: Text("Thư mục"),),
            Center(child: Text("Thư mục"),),
          ],
        )
        ),
      ],),
    );
  }
}

