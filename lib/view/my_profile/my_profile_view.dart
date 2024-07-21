import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';

class MyProfileView extends StatefulWidget{
  const MyProfileView({super.key});
  @override
  State<MyProfileView> createState() => _MyProfileView();
}
class _MyProfileView extends State<MyProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bg,
      appBar: AppBar(
        titleSpacing: 0.0,
        leadingWidth: 115,
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: TColor.lightGray),  // Back icon with color matching text
                onPressed: () {

                },
              ),
              // Image.asset(
              //   'assets/img/logo_app.png',
              //   fit: BoxFit.contain,
              //
              // ),
            ],
          ),
        ),
        title:
        Container(
          child: Text(
            "Thông tin cá nhân",
            style: TextStyle(
                color: TColor.primaryTextM,
                fontSize: 27,
                fontWeight: FontWeight.w900
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration:  BoxDecoration(
                      color: TColor.darkGray,
                      shape: BoxShape.circle,
                      // border: Border.all(
                      //   color: TColor.primary, // border color
                      //   width: 1.0, // border width
                      // ),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 32.0,
                    ),
                  ),
                  const SizedBox(height: 8.0), // space between the circle and text
                  Text(
                    'Dang Phuong',
                    style: TextStyle(
                      fontSize: 26.0,
                      color: TColor.primaryText.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Container(
                    margin: const EdgeInsets.only(left: 24,right: 24,bottom: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: TColor.darkGray,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: TColor.darkGray),
                    ),
                    child:Row(
                      children: [
                        Icon(Icons.person_outline, color: TColor.lightGray.withOpacity(0.5)),
                        const SizedBox(width: 10,),
                        Text("Dang Phuong",style: TextStyle(fontSize: 16,color: TColor.lightGray),),
                        const Spacer(), // This will push the next widget to the far right
                        Image.asset(
                          'assets/img/edit_icon.png',
                          width: 16,
                          height: 16,
                          fit: BoxFit.cover,
                        ),
                      ],
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.only(left: 24,right: 24, bottom: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: TColor.darkGray,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: TColor.darkGray),
                    ),
                    child:Row(
                      children: [
                        Icon(Icons.mail_outline, color: TColor.lightGray.withOpacity(0.5)),
                        const SizedBox(width: 10,),
                        Text("dangphuong@gmail.com",style: TextStyle(fontSize: 16,color: TColor.lightGray),),
                        const Spacer(), // This will push the next widget to the far right
                        Image.asset(
                          'assets/img/edit_icon.png',
                          width: 16,
                          height: 16,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 400,),
                  Container(
                    width: 200,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: TColor.primary,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/logout_icon.png',
                          width: 24,
                          height: 22,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Đăng xuất",
                          style: TextStyle(
                            fontSize: 20,
                            color: TColor.primaryText.withOpacity(0.9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            )
          ],
        )
      ),
    );
  }
}