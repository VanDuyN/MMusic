import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
class YourFolderCell extends StatelessWidget {
  final Map mObj;
  const YourFolderCell({super.key, required this.mObj});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        children:[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              "assets/img/folder.png",
              width: 84,
              height: 82,
              fit: BoxFit.fill,
            ),
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
                  mObj["number"] +"Danh sách phát",
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
    );
  }
}
