import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mmusic/view_model/splash_view_model.dart';
class SplashView extends StatefulWidget{
  const SplashView({super.key});
  @override
  State<SplashView> createState()=> _SplashViewState();

}
class _SplashViewState extends State<SplashView>{
  final splashVM = Get.put(SplashViewModel());
  @override
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
    splashVM.loadView();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
    );
  }
}