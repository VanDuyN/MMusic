import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
class ArtistCell extends StatelessWidget {
  final Map mObj;
  const ArtistCell({super.key, required this.mObj});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
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
            margin: const EdgeInsets.only(top: 10),
            child: Text(
                mObj["name"],
                style: TextStyle(
                  color: TColor.primaryText80,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
            ),
          ),
        ],
      ),
    );
  }
}
