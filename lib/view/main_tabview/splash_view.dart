import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class SplashView extends StatefulWidget{
  const SplashView({super.key});
  @override
  State<SplashView> createState()=> _SplashViewState();

}
class _SplashViewState extends State<SplashView>{
  @override
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(

    );
  }
}