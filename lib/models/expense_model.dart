class ExpenseModel {
  double value;
  bool income;
  ExpenseCategory type;
  String? note;
  ExpenseModel({
    required this.value,
    required this.income,
    required this.type,
    required this.note,
  });

  Map<String, dynamic> toJson() => {
    'note': note,
    'income': income,
    'type': type,
    'value': value,
  };
}

enum ExpenseCategory { home, food, transit, shop, bills, more }
