import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/login/login_view.dart';
import 'package:mmusic/view/main_tabview/main_tabview.dart';
class SplashViewModel extends GetxController{
  final SongHandler songHandler;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  SplashViewModel( {required this.songHandler});
  void loadView() async{
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => MainTabview(songHandler: songHandler));
  }
  void openDrawer(){
    scaffoldKey.currentState?.openDrawer();
  }
  void closeDrawer(){
    scaffoldKey.currentState?.closeDrawer();
  }

}