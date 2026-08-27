import 'package:flutter/cupertino.dart';
import 'package:track_expenses/screens/onboarding_screen.dart';

class SplashProvider extends ChangeNotifier {
  Future<void> navigator(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }
}