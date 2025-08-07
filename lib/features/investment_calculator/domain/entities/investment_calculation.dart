import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_finance_calculator/core/share/money_cents.dart';

part 'investment_calculation.freezed.dart';

enum ContributionFrequency {
  monthly,
  quarterly,
  annually,
}

@freezed
class InvestmentCalculation with _$InvestmentCalculation {
  const factory InvestmentCalculation({
    required MoneyCents initialInvestment,
    required MoneyCents regularContribution,
    required ContributionFrequency contributionFrequency,
    required double annualInterestRate,
    required int investmentPeriodInYears,
    required MoneyCents futureValue,
    required MoneyCents totalContributions,
    required MoneyCents totalEarnings,
  }) = _InvestmentCalculation;
}
