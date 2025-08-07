import 'package:personal_finance_calculator/core/database/database_helper.dart';
import 'package:personal_finance_calculator/features/history/data/models/history_item_model.dart';
import 'package:personal_finance_calculator/features/history/domain/entities/history_item.dart';
import 'package:personal_finance_calculator/features/history/domain/repositories/i_history_repository.dart';
import 'package:personal_finance_calculator/features/loan_calculator/data/models/loan_calculation_model.dart';
import 'package:personal_finance_calculator/features/investment_calculator/data/models/investment_calculation_model.dart';

class HistoryRepository implements IHistoryRepository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<HistoryItem>> getHistory() async {
    final db = await dbHelper.database;
    final loanMaps = await db.query('loan_calculations', orderBy: 'createdAt DESC');
    final investmentMaps = await db.query('investment_calculations', orderBy: 'createdAt DESC');

    final List<HistoryItem> historyItems = [];

    for (final map in loanMaps) {
      final model = LoanCalculationModel.fromJson(map);
      historyItems.add(HistoryItem(
        id: map['id'] as int,
        type: HistoryItemType.loan,
        createdAt: DateTime.parse(map['createdAt'] as String),
        loanCalculation: model.toDomain(),
      ));
    }

    for (final map in investmentMaps) {
      final model = InvestmentCalculationModel.fromJson(map);
      historyItems.add(HistoryItem(
        id: map['id'] as int,
        type: HistoryItemType.investment,
        createdAt: DateTime.parse(map['createdAt'] as String),
        investmentCalculation: model.toDomain(),
      ));
    }

    historyItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return historyItems;
  }

  @override
  Future<void> deleteHistoryItem(int id, HistoryItemType type) async {
    final db = await dbHelper.database;
    String table;
    switch (type) {
      case HistoryItemType.loan:
        table = 'loan_calculations';
        break;
      case HistoryItemType.investment:
        table = 'investment_calculations';
        break;
    }
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
