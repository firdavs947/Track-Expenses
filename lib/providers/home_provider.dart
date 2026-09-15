import 'package:flutter/material.dart';
import 'package:track_expenses/models/expense_model.dart';
import 'package:track_expenses/service/database_service.dart';

class HomeProvider extends ChangeNotifier {
  double balance = 0;
  double totalIncome = 0;
  double totalOutcome = 0;
  List<ExpenseModel> expenses = [];

  
  HomeProvider() {
    getExpensesFromDb();
  }

  Future<void> getExpensesFromDb() async {
    try {
      final data = await DatabaseService.getAllExpenses();
      expenses = data;
      _calculateTotals();
    } catch (e) {
      debugPrint('Ошибка при получении данных: $e');
    }
  }

  Future<void> clearDb({required VoidCallback onSuccess}) async {
    await DatabaseService.clearDb();
    expenses.clear();
    balance = 0;
    totalIncome = 0;
    totalOutcome = 0;
    notifyListeners();
    onSuccess();
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
    await getExpensesFromDb();
  }
}