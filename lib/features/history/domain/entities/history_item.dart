import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';
import 'package:personal_finance_calculator/features/investment_calculator/domain/entities/investment_calculation.dart';

part 'history_item.freezed.dart';

enum HistoryItemType {
  loan,
  investment,
}

@freezed
class HistoryItem with _$HistoryItem {
  const factory HistoryItem({
    required int id,
    required HistoryItemType type,
    required DateTime createdAt,
    LoanCalculation? loanCalculation,
    InvestmentCalculation? investmentCalculation,
  }) = _HistoryItem;
}
