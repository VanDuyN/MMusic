import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
class CategoryCell extends StatelessWidget {
  final Map mObj;
  const CategoryCell({super.key, required this.mObj});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          borderRadius: BorderRadius.circular(7)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:const EdgeInsets.only(top: 20,left: 20),
            child: Text(
              mObj["name"],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: TColor.primaryText,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  right: -15,
                  bottom: -20,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(3.1415926535897932 / 4.5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(48),
                        child: Image.asset(
                          mObj["image"],
                          width: 85,
                          height: 85,
                          fit: BoxFit.fill,
                          isAntiAlias: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
