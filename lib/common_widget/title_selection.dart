import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';

class TitleSelection extends StatelessWidget {
  final String title;
  const TitleSelection({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(padding:
    const EdgeInsets.only(left: 15,top: 20),
      child: Text(
        title,
        style: TextStyle(
          color: TColor.primaryText,
          fontSize: 25,
          fontWeight: FontWeight.w800
        ),
      ),
    );
  }
}
