import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:track_expenses/models/expense_model.dart';

class DatabaseService {
  static late Database db;
  static final String dataBaseName = "expenses.db";
  // ignore: prefer_typing_uninitialized_variables

  static Future<void> init(String filePath) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

   db =   await openDatabase(path, version: 1, onCreate: _createDB);
    } catch (e, stack) {
      print(e);
    }
  }

  static Future _createDB(Database database, int version) async {
    await database.execute('''
    CREATE TABLE expenses (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      note TEXT,
      value REAL,
      createdAt TEXT,
      type TEXT,
      income INTEGER
    )
  ''');
  }

  static Future<void> closeDB() async => await db.close();

 static Future<void> addExpenseToDb(ExpenseModel expense) async {
    Map<String, dynamic> row = {
      'note': expense.note,
      'value': expense.value,
      'income': expense.income ? 1 : 0,
      'type': expense.type.name,
    };

    await db.insert('expenses', row);
  }

  static Future<List<ExpenseModel>> getAllExpenses() async {
  // 1. Fetch all rows from the expenses table
  final List<Map<String, dynamic>> expense = await db.query('expenses');

  // 2. Convert the List<Map> into a List<ExpenseModel>
  return List.generate(expense.length, (index) {
    final row = expense[index];

    return ExpenseModel(
      note: row['note'] as String? ?? "Empty",
      value: row['value'] as double,
      income: (row['income'] as int) == 1,
      type: ExpenseCategory.values.firstWhere(
        (e) => e.toString() == row['type'] || e.name == row['type'],
        orElse: () => ExpenseCategory.home, // Default fallback
      ),
    ); // ExpenseModel
  }); // List.generate
}


}
