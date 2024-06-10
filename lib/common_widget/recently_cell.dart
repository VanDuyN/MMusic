import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
class RecentlyCell extends StatelessWidget {

  final Map mObj;
  const RecentlyCell({super.key, required this.mObj});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 182,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
      ),
      margin: const EdgeInsets.only(left: 15,top:5, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.asset(
              mObj["image"],
              width: 182,
              height: 182,
              fit: BoxFit.fill,
            ),
          ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.only(left: 10,right: 1),
              child: Text(
                mObj["name"],
                style: TextStyle(
                  color: TColor.primaryText80,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.only(left: 10,right: 1),
            child: Text(
              mObj["artist"],
              style: TextStyle(
                color: TColor.primaryText35,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
