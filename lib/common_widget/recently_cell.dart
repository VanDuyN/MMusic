import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:mmusic/view/main_player/main_player_view.dart';
class RecentlyCell extends StatelessWidget {
  final Map mObj;
  const RecentlyCell({super.key, required this.mObj});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //Get.to(()=> const MainPlayerView());
      },
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.only(left: 10, top: 5, right: 20),
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              alignment: AlignmentDirectional.topStart,
              image: AssetImage(
                mObj["image"],
              ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 10,left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mObj["name"],
                style: TextStyle(
                    color: TColor.primaryText80,
                    fontSize: 17,
                    fontWeight: FontWeight.w700
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
