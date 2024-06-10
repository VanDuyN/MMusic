import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';

class IconTextRow extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  const IconTextRow({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(
            Icons.person,
            color: TColor.primary,
            size: 24,
          ),
          title: Text(
            "Thông tin cá nhân",
            style: TextStyle(
              color: TColor.primaryText.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: (){

          },
        ),
        Divider(
          color: TColor.primaryText.withOpacity(0.07),
          indent: 70,
        ),
        ListTile(
          leading: Icon(
            Icons.person,
            color: TColor.primary,
            size: 24,
          ),
          title: Text(
            "Thông tin cá nhân",
            style: TextStyle(
              color: TColor.primaryText.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: (){

          },
        ),
        Divider(
          color: TColor.primaryText.withOpacity(0.07),
          indent: 70,
        ),
        ListTile(
          leading: Icon(
            Icons.person,
            color: TColor.primary,
            size: 24,
          ),
          title: Text(
            "Thông tin cá nhân",
            style: TextStyle(
              color: TColor.primaryText.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: (){

          },
        ),
        Divider(
          color: TColor.primaryText.withOpacity(0.07),
          indent: 70,
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: TColor.primary,
            size: 24,
          ),
          title: Text(
            "Đăng xuất",
            style: TextStyle(
              color: TColor.primaryText.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: (){
          },
        ),
        Divider(
          color: TColor.primaryText.withOpacity(0.07),
          indent: 70,
        ),
      ],
    );
  }
}
