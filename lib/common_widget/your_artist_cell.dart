import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
class YourArtistCell extends StatelessWidget {
  final Map mObj;
  const YourArtistCell({super.key, required this.mObj});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Row(
        children: [
          CircleAvatar(
            radius: 43,
            child: ClipOval(
              child: Image.asset(
                mObj["image"],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text(
              mObj["name"],
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
