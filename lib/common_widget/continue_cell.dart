import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
class ContinueCell extends StatelessWidget {
  final Map mObj;
  const ContinueCell({super.key, required this.mObj});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 183,
      height: 80,
      decoration: BoxDecoration(
        color: TColor.primaryItem20,
        borderRadius: BorderRadius.circular(9),
      ),
      //color: TColor.primaryItem20,
      margin: const EdgeInsets.symmetric(horizontal:5,vertical: 8),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.asset(
              mObj["image"],
              width: 65,
              height: 65,
              fit: BoxFit.fill,
            ),
          ),
          Center(
              child:
              Container(
                padding:const EdgeInsets.only(left: 10,right: 5),
                  child: Text(
                    mObj["name"],
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              )
          ),
        ],
      ),
    );
  }
}
