import 'package:audio_service/audio_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'package:track_expenses/consts/themes/app_themes.dart';
import 'package:track_expenses/providers/home_provider.dart';
import 'package:track_expenses/screens/home_screen.dart';
import 'package:track_expenses/screens/splash_screen.dart';
import 'package:track_expenses/service/custom_audio_service.dart';
import 'package:track_expenses/service/database_service.dart';
import 'package:track_expenses/widgets/no_interner.dart';

late AudioPlayerHandler audioHandler;

GlobalKey<NavigatorState> navigatorkey = GlobalKey();

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.init('expenses');

  audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.example.app.channel.audio',
      androidNotificationChannelName: 'Воспроизведение музыки',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomeProvider())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isSheetOpen = false;

  @override
  void initState() {
    Connectivity().onConnectivityChanged.listen((status) {
      print('Connectivity status $status');
      if (status.contains(ConnectivityResult.none)) {
        WidgetsBinding.instance.addPostFrameCallback((v) {
          NoInterner.widgetnikorsatish();
          isSheetOpen = true;
        });
      } else if (status.contains(ConnectivityResult.wifi) ||
          status.contains(ConnectivityResult.mobile) ||
          status.contains(ConnectivityResult.ethernet)) {
        WidgetsBinding.instance.addPostFrameCallback((v) {
          if (isSheetOpen == true) {
            Navigator.pop(navigatorkey.currentState!.context);
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorkey,
      debugShowCheckedModeBanner: false,
      title: 'Track expenses',
      theme: AppTheme.lightTheme,
      home: SplashScreen(),
    );
  }
}
