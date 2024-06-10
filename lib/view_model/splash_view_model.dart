import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/view/main_tabview/main_tabview.dart';
class SplashViewModel extends GetxController{
  var scaffoldKey = GlobalKey<ScaffoldState>();
  void loadView() async{
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => const MainTabview());
  }
  void openDrawer(){
    scaffoldKey.currentState?.openDrawer();
  }
  void closeDrawer(){
    scaffoldKey.currentState?.closeDrawer();
  }
}