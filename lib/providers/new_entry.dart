import 'package:flutter/material.dart';
import 'package:track_expenses/gen/assets.gen.dart';
import 'package:track_expenses/models/expense_model.dart';
import 'package:track_expenses/service/database_service.dart';

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

  bool isLoading = false;

  // bool expense = true;
  // bool income = false;
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

  Future<void> sendincome({
    required ExpenseModel expense,
    required Function onError,
    required Function onSuccess,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      await DatabaseService.addExpenseToDb(
        ExpenseModel(
          id: 0,
          value: expense.value,
          income: expense.income,
          type: expense.type,
          note: expense.note,
        ),
      );
      onSuccess();
    } catch (e) {
      onError();
    } finally {
      isLoading = false;
    }
  }
}
