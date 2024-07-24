import 'package:flutter/material.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:get/get.dart';

class MyProfileView extends StatefulWidget{
  final String name;
  final String email;
  final String img;
  const MyProfileView({super.key, required this.name, required this.email, required this.img});
  @override
  State<MyProfileView> createState() => _MyProfileView();
}
class _MyProfileView extends State<MyProfileView> {
  var url =API().getUrl();
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
                  Get.back();
                },
              ),
            ],
          ),
        ),
        title:
         Text(
          "Thông tin cá nhân",
          style: TextStyle(
              color: TColor.primaryTextM,
              fontSize: 27,
              fontWeight: FontWeight.w900
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 120,
                      backgroundColor: TColor.primary,
                        child: ClipOval(
                          child: Image.network(
                            widget.img,
                            width: double.maxFinite,
                            height: double.maxFinite,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Image.asset(
                                  "assets/img/logo_app.png",
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  color: TColor.primaryText,
                                  fit: BoxFit.cover
                              );
                            }
                          ),
                      ),
                    ),
                    // Container(
                    //   width: 200,
                    //   height: 200,
                    //   decoration:  BoxDecoration(
                    //     color: TColor.darkGray,
                    //     shape: BoxShape.circle,
                    //
                    //   ),
                    //   child: const Icon(
                    //     Icons.person_outline,
                    //     color: Colors.white,
                    //     size: 170,
                    //   ),
                    // ),
                    const SizedBox(height: 40,),
                    Container(
                      margin: const EdgeInsets.only(left: 24,right: 24,bottom: 20),
                      padding: const EdgeInsets.only(left: 10,top: 15,right: 10,bottom: 15),
                      decoration: BoxDecoration(
                        color: TColor.darkGray,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: TColor.darkGray),
                      ),
                      child:Row(
                        children: [
                          Icon(Icons.person_outline, color: TColor.lightGray.withOpacity(0.5)),
                          const SizedBox(width: 10,),
                          Text(widget.name,style: TextStyle(fontSize: 18,color: TColor.lightGray,fontWeight: FontWeight.w700),),
                          const Spacer(), // This will push the next widget to the far right
                          Image.asset(
                            'assets/img/edit_icon.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 24,right: 24, bottom: 20),
                      padding: const EdgeInsets.only(left: 10,top: 15,right: 10,bottom: 15),
                      decoration: BoxDecoration(
                        color: TColor.darkGray,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: TColor.darkGray),
                      ),
                      child:Row(
                        children: [
                          Icon(Icons.mail_outline, color: TColor.lightGray.withOpacity(0.5)),
                          const SizedBox(width: 10,),
                          Text(widget.email,style: TextStyle(fontSize: 18,color: TColor.lightGray,fontWeight: FontWeight.w700),),
                        ],
                      ),
                    ),

                    // Container(
                    //   width: 200,
                    //   alignment: Alignment.center,
                    //   padding: const EdgeInsets.all(8),
                    //   decoration: BoxDecoration(
                    //     color: TColor.primary,
                    //     borderRadius: BorderRadius.circular(50.0),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Image.asset(
                    //         'assets/img/logout_icon.png',
                    //         width: 24,
                    //         height: 22,
                    //         fit: BoxFit.cover,
                    //       ),
                    //       const SizedBox(width: 10),
                    //       Text(
                    //         "Đăng xuất",
                    //         style: TextStyle(
                    //           fontSize: 20,
                    //           color: TColor.primaryText.withOpacity(0.9),
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )

                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}