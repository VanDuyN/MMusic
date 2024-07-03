import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/view/register/register_view.dart';
import 'package:mmusic/view/search/search_view.dart';
import 'package:mmusic/view/splash_view.dart';
import 'package:mmusic/view/login/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Music MFA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Roboto",
        scaffoldBackgroundColor: TColor.bg,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: TColor.primaryText,
              displayColor: TColor.primaryText,
            ),
        colorScheme: ColorScheme.fromSeed(seedColor: TColor.primary),
        useMaterial3: false,
      ),
      home: const SplashView(),
    );
  }
}
