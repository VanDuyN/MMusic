import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:audio_service/audio_service.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/notifiers/song_provider.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/main_tabview/splash_view.dart';
import 'package:provider/provider.dart';

SongHandler _songHandler = SongHandler();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _songHandler= await AudioService.init(
      builder: ()=> SongHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: "huflit.edu.vn.mmusic",
      androidNotificationChannelName: 'Music MFA',
      androidNotificationOngoing: true,
      androidShowNotificationBadge: true,
    )
  );
  runApp(
    MultiProvider(
      providers: [
        // Provide the SongsProvider with the loaded songs and SongHandler
        ChangeNotifierProvider(
          create: (context) => SongsProvider()..loadSongs(_songHandler),
        ),
      ],
      // Use the MainApp widget as the root of the application
      child: const MyApp(),
    ),
  );

  // Set preferred orientations for the app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        colorScheme: ColorScheme.fromSeed(
            seedColor: TColor.primary),
        useMaterial3: false,

      ),
      home: SplashView(songHandler: _songHandler),
      //home: const MyProfileView(),
    );
  }
}

