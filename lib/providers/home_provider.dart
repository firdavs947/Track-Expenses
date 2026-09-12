
import 'package:flutter/material.dart';
import 'package:track_expenses/models/expense_model.dart';
import 'package:track_expenses/service/database_service.dart';

class HomeProvider extends ChangeNotifier {
  // double balance = Random().nextInt(99001) + 1000; // от 1000 до 100000
  double balance = 0;
  double totalIncome = 0;
  double totalOutcome = 0;
  // Future<void> getOverAllBalance() async {
  //   balance = 0;
  //   for (var i = 0; i < expenses.length; i++) {
  //     balance += expenses[i].value;
  //   }
  //   notifyListeners();
  // }

  List<ExpenseModel> expenses = [];
  Future<void> getExpensesFromDb() async {
    try {
      final data = await DatabaseService.getAllExpenses();
      expenses = data;
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      _calculateTotals();
    }
  }

  Future<void> clearDb({required Function onSuccess}) async {
    await DatabaseService.clearDb();
    balance = 0;
    totalIncome = 0;
    totalOutcome = 0;
    onSuccess();
    expenses.clear();
    notifyListeners();
  }

  void _calculateTotals() {
    double income = 0;
    double outcome = 0;

  for (var i = 0; i < expenses.length; i++) {
  final e = expenses[i];
  if (e.income) {
    income += e.value;
  } else {
    outcome += e.value.abs();
  }
}

    totalIncome = income;
    totalOutcome = outcome;
    balance = income - outcome;

    notifyListeners();
  }

  Future<void> deleteItem(int id) async {
    await DatabaseService.deleteItemInDb(id);
    getExpensesFromDb();
  }
}
