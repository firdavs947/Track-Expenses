class ExpenseModel {
  int id;
  double value;
  bool income;
  ExpenseCategory type;
  String? note;
  ExpenseModel({
    required this.id,
    required this.value,
    required this.income,
    required this.type,
    required this.note,
  });

  Map<String, dynamic> toJson() => {
    'id':id,
    'note': note,
    'income': income,
    'type': type,
    'value': value,
  };
}

enum ExpenseCategory { home, food, transit, shop, bills, more }
