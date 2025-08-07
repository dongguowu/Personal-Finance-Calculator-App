import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_finance_calculator/features/investment_calculator/domain/entities/investment_calculation.dart';
import 'package:personal_finance_calculator/core/share/money_cents.dart';

part 'investment_calculation_model.freezed.dart';
part 'investment_calculation_model.g.dart';

@freezed
class InvestmentCalculationModel with _$InvestmentCalculationModel {
  const InvestmentCalculationModel._();

  const factory InvestmentCalculationModel({
    required int initialInvestment,
    required int regularContribution,
    required ContributionFrequency contributionFrequency,
    required double annualInterestRate,
    required int investmentPeriodInYears,
    required int futureValue,
    required int totalContributions,
    required int totalEarnings,
  }) = _InvestmentCalculationModel;

  factory InvestmentCalculationModel.fromDomain(InvestmentCalculation domain) {
    return InvestmentCalculationModel(
      initialInvestment: domain.initialInvestment.cents,
      regularContribution: domain.regularContribution.cents,
      contributionFrequency: domain.contributionFrequency,
      annualInterestRate: domain.annualInterestRate,
      investmentPeriodInYears: domain.investmentPeriodInYears,
      futureValue: domain.futureValue.cents,
      totalContributions: domain.totalContributions.cents,
      totalEarnings: domain.totalEarnings.cents,
    );
  }

  InvestmentCalculation toDomain() {
    return InvestmentCalculation(
      initialInvestment: MoneyCents.fromCents(initialInvestment),
      regularContribution: MoneyCents.fromCents(regularContribution),
      contributionFrequency: contributionFrequency,
      annualInterestRate: annualInterestRate,
      investmentPeriodInYears: investmentPeriodInYears,
      futureValue: MoneyCents.fromCents(futureValue),
      totalContributions: MoneyCents.fromCents(totalContributions),
      totalEarnings: MoneyCents.fromCents(totalEarnings),
    );
  }

  factory InvestmentCalculationModel.fromJson(Map<String, dynamic> json) =>
      _$InvestmentCalculationModelFromJson(json);
}
