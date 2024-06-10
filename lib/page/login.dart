import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mmusic/common/color_extension.dart';
class Login extends StatefulWidget{
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login>{
  @override
  void initState(){

  }
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool remember = false;
    return Padding(
        padding:  const EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                   alignment: Alignment.center,

                 ),

                 const SizedBox(height: 5,),


              ],
            ),
          ),
        ),);
  }
}