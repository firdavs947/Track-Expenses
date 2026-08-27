import 'package:flutter/material.dart';
import 'package:track_expenses/gen/assets.gen.dart';

class NewEntry extends ChangeNotifier {
  List category = [
    Assets.icons.home,
    Assets.icons.food,
    Assets.icons.transit,
    Assets.icons.foodsMarket,
    Assets.icons.biils,
    Assets.icons.more,
  ];
  List categorytext = ['HOME', 'FOOD', 'TRANSIT', 'SHOP', 'BILLS', 'MORE'];

  int currentCategory = 0;

  bool expense = true;
  bool income = false;
  void onPageChanged(int index) {
    currentCategory = index;
    notifyListeners();
  }

  int selectedindex2 = 0;
 void selected2(int index) {
    selectedindex2 = index;
    notifyListeners();
  }



  int selectedindex = 0;
   void selected(int index) {
    selectedindex = index;
    notifyListeners();
  }

}
