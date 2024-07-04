import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:get/get.dart';
import '../../common_widget/for_you_cell.dart';
import '../../common_widget/title_selection.dart';
import '../../view_model/home_view_model.dart';


class NotificationView extends StatefulWidget{
  const NotificationView({super.key});
  @override
  State<NotificationView> createState() => _NotificationView();
}

class _NotificationView extends State<NotificationView> {
  final homeVM = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: TColor.bg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // Đặt chiều cao tùy chỉnh cho AppBar
        child: AppBar(
          backgroundColor: TColor.bg,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 30.0,
            onPressed: () {
              Get.back();
            },
          ),
          title: Text("Hôm nay nghe gì"),

        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

        ],
        ),
      ),

    );
  }
}