import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('finance_calculator.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE loan_calculations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        loanAmount INTEGER NOT NULL,
        annualInterestRate REAL NOT NULL,
        loanTermInYears INTEGER NOT NULL,
        monthlyPayment INTEGER NOT NULL,
        totalInterestPaid INTEGER NOT NULL,
        totalRepayment INTEGER NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE investment_calculations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        initialInvestment INTEGER NOT NULL,
        regularContribution INTEGER NOT NULL,
        contributionFrequency TEXT NOT NULL,
        annualInterestRate REAL NOT NULL,
        investmentPeriodInYears INTEGER NOT NULL,
        futureValue INTEGER NOT NULL,
        totalContributions INTEGER NOT NULL,
        totalEarnings INTEGER NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }
}
