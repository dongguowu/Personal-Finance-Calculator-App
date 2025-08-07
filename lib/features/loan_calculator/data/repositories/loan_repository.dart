import 'package:personal_finance_calculator/core/database/database_helper.dart';
import 'package:personal_finance_calculator/features/loan_calculator/data/models/loan_calculation_model.dart';
import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';
import 'package:personal_finance_calculator/features/loan_calculator/domain/repositories/i_loan_repository.dart';
import 'package:sqflite/sqflite.dart';

class LoanRepository implements ILoanRepository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<void> saveLoanCalculation(LoanCalculation calculation) async {
    final db = await dbHelper.database;
    final model = LoanCalculationModel.fromDomain(calculation);
    await db.insert('loan_calculations', model.toJson());
  }

  @override
  Future<LoanCalculation?> getLastLoanCalculation() async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'loan_calculations',
      orderBy: 'createdAt DESC',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return LoanCalculationModel.fromJson(maps.first).toDomain();
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteLoanCalculation(LoanCalculation calculation) async {
    final db = await dbHelper.database;
    final model = LoanCalculationModel.fromDomain(calculation);
    await db.delete(
      'loan_calculations',
      where: 'loanAmount = ? AND annualInterestRate = ? AND loanTermInYears = ?',
      whereArgs: [model.loanAmount, model.annualInterestRate, model.loanTermInYears],
    );
  }
}
