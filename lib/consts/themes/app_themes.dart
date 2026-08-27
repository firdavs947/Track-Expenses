import 'package:flutter/material.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Inter', // шрифт по умолчанию
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: 'Jet', // второй шрифт для заголовков
        ),

      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(400, 48),
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.white,
        ),
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: AppColors.black,
        onPrimary: Colors.white,
        error: AppColors.red,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
    );
  }
}
