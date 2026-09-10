class ExpenseModel {
  int id;
  double value;
  bool income;
  ExpenseCategory type;
  String? note;
  String? image;
  ExpenseModel({
    required this.id,
    required this.value,
    required this.income,
    required this.type,
    required this.note,
    required this.image
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'note': note,
    'income': income,
    'type': type,
    'value': value,
  };
}

enum ExpenseCategory { home, food, transit, shop, bills, more }
