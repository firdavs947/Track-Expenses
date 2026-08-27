import 'package:flutter/material.dart';
import 'package:track_expenses/consts/themes/app_themes.dart';
import 'package:track_expenses/screens/home_screen.dart';
import 'package:track_expenses/screens/main_screen.dart';
import 'package:track_expenses/screens/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'Track expenses',
     theme: AppTheme.lightTheme,
     home: SplashScreen(),
    );
  }
}
