import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:track_expenses/consts/themes/app_themes.dart';
import 'package:track_expenses/providers/home_provider.dart';
import 'package:track_expenses/screens/home_screen.dart';
import 'package:track_expenses/service/custom_audio_service.dart';
import 'package:track_expenses/service/database_service.dart';

late AudioPlayerHandler audioHandler;

Future<void> main() async {
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
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Track expenses',
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}