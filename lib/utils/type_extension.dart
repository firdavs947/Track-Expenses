import 'package:track_expenses/gen/assets.gen.dart';
import 'package:track_expenses/models/expense_model.dart';

extension TypeExtension on String {
  String get checkType {
    if (this == ExpenseCategory.home.name) {
      return Assets.icons.home;
    }else if (this == ExpenseCategory.food.name) {
      return Assets.icons.food;
    }else if (this == ExpenseCategory.bills.name) {
      return Assets.icons.biils;
    }else if (this == ExpenseCategory.transit.name) {
      return Assets.icons.transit;
    }else if (this == ExpenseCategory.shop.name) {
      return Assets.icons.shop;
    } else  {
      return Assets.icons.more;
    }
  }
}
