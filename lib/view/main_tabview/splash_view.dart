import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view_model/splash_view_model.dart';
import 'package:permission_handler/permission_handler.dart';
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
    check();
    splashVM = Get.put(SplashViewModel(songHandler: widget.songHandler));
    splashVM.loadView();
  }
  void check() async{
    var statusM = await Permission.mediaLibrary.request();
    var statusF = await Permission.storage.request();
    if (statusF.isGranted) {
      debugPrint('Quyền truy cập Apple Music đã được cấp');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Permission is not Granted")));
    }
    if (statusM.isGranted ) {
      debugPrint('Quyền truy cập đã được cấp');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Permission is not Granted")));
    }
  }
  @override
  Widget build(BuildContext context){
    return Center(
      child: Image.asset("assets/img/logo_app.png",width: 500,height: 500,),
    );
  }
}