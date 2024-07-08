import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view_model/splash_view_model.dart';
class SplashView extends StatefulWidget{
  final SongHandler songHandler;

  const SplashView({super.key, required this.songHandler});
  @override
  State<SplashView> createState()=> _SplashViewState();

}
class _SplashViewState extends State<SplashView>{
  late final SplashViewModel splashVM;
  @override
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
    splashVM = Get.put(SplashViewModel(songHandler: widget.songHandler));
    splashVM.loadView();
  }
  @override
  Widget build(BuildContext context){
    return Center(
      child: Image.asset("assets/img/logo_app.png",width: 500,height: 500,),
    );
  }
}