import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
class LibraryCell extends StatelessWidget {
  final Map mObj;
  const LibraryCell({super.key,required this.mObj});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        children:[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              mObj["image"],
              width: 84,
              height: 82,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
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
                  mObj["artist"],
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
