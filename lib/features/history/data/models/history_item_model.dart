import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_finance_calculator/features/history/domain/entities/history_item.dart';
import 'package:personal_finance_calculator/features/loan_calculator/data/models/loan_calculation_model.dart';
import 'package:personal_finance_calculator/features/investment_calculator/data/models/investment_calculation_model.dart';

part 'history_item_model.freezed.dart';
part 'history_item_model.g.dart';

@freezed
class HistoryItemModel with _$HistoryItemModel {
  const HistoryItemModel._();

  const factory HistoryItemModel({
    required int id,
    required HistoryItemType type,
    required DateTime createdAt,
    LoanCalculationModel? loanCalculation,
    InvestmentCalculationModel? investmentCalculation,
  }) = _HistoryItemModel;

  factory HistoryItemModel.fromDomain(HistoryItem domain) {
    return HistoryItemModel(
      id: domain.id,
      type: domain.type,
      createdAt: domain.createdAt,
      loanCalculation: domain.loanCalculation != null
          ? LoanCalculationModel.fromDomain(domain.loanCalculation!)
          : null,
      investmentCalculation: domain.investmentCalculation != null
          ? InvestmentCalculationModel.fromDomain(domain.investmentCalculation!)
          : null,
    );
  }

  HistoryItem toDomain() {
    return HistoryItem(
      id: id,
      type: type,
      createdAt: createdAt,
      loanCalculation: loanCalculation?.toDomain(),
      investmentCalculation: investmentCalculation?.toDomain(),
    );
  }

  factory HistoryItemModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryItemModelFromJson(json);
}
