import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/view/play_list/play_list_view.dart';
class YourPlaylistCell extends StatelessWidget {
  final Map mObj;

  const YourPlaylistCell({super.key, required this.mObj});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=> const PlayListView());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Image.asset(
              mObj["image"],
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
                    mObj["name"],
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
    );
  }
}
