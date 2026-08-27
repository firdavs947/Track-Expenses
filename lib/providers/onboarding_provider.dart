import 'package:flutter/material.dart';
import 'package:track_expenses/gen/assets.gen.dart';

class OnboardingProvider extends ChangeNotifier {
  List icon = [Assets.icons.statistic, Assets.icons.check, Assets.icons.corp];

  List<Map> info = [
    {
      "title": "Track Everything",
      "description":
          "Log your daily income and expenses instantly. No clutter, just the data you need.",
    },
    {
      "title": "See the Big Picture",
      "description":
          "Visualize your spending habits with elegant charts. Know exactly where you stand.",
    },
    {
      "title": "Own Your Budget",
      "description":
          "Make smarter financial decisions every single day. Let’s get your money organized.",
    },
  ];

  int currentPage = 0;

  void onPageChanged(int index) {
    currentPage = index;
    notifyListeners();
  }
}
