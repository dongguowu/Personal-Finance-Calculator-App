import 'package:personal_finance_calculator/core/database/database_helper.dart';
import 'package:personal_finance_calculator/features/investment_calculator/data/models/investment_calculation_model.dart';
import 'package:personal_finance_calculator/features/investment_calculator/domain/entities/investment_calculation.dart';
import 'package:personal_finance_calculator/features/investment_calculator/domain/repositories/i_investment_repository.dart';
import 'package:sqflite/sqflite.dart';

class InvestmentRepository implements IInvestmentRepository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<void> saveInvestmentCalculation(InvestmentCalculation calculation) async {
    final db = await dbHelper.database;
    final model = InvestmentCalculationModel.fromDomain(calculation);
    await db.insert('investment_calculations', model.toJson());
  }

  @override
  Future<InvestmentCalculation?> getLastInvestmentCalculation() async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'investment_calculations',
      orderBy: 'createdAt DESC',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return InvestmentCalculationModel.fromJson(maps.first).toDomain();
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteInvestmentCalculation(InvestmentCalculation calculation) async {
    final db = await dbHelper.database;
    final model = InvestmentCalculationModel.fromDomain(calculation);
    await db.delete(
      'investment_calculations',
      where: 'initialInvestment = ? AND regularContribution = ? AND contributionFrequency = ? AND annualInterestRate = ? AND investmentPeriodInYears = ?',
      whereArgs: [model.initialInvestment, model.regularContribution, model.contributionFrequency.toString(), model.annualInterestRate, model.investmentPeriodInYears],
    );
  }
}
