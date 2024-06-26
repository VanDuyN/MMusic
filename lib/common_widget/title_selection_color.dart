import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
class TitleSelectionColor extends StatelessWidget {
  final String title;
  const TitleSelectionColor({super.key, required this.title});

  @override
  Widget build(BuildContext context) {

    return Padding(padding:
    const EdgeInsets.only(left: 10),
      child: Text(
        title,
        style: TextStyle(
            color: TColor.primaryTextTitleColor,
            fontSize: 16,
            fontWeight: FontWeight.w800
        ),
      ),
    );
  }
}
