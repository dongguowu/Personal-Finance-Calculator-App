import 'package:personal_finance_calculator/core/share/money_cents.dart';
import 'package:personal_finance_calculator/features/investment_calculator/domain/entities/investment_calculation.dart';
import 'dart:math';

class CalculateInvestmentReturnUseCase {
  InvestmentCalculation call({
    required MoneyCents initialInvestment,
    required MoneyCents regularContribution,
    required ContributionFrequency contributionFrequency,
    required double annualInterestRate,
    required int investmentPeriodInYears,
  }) {
    if (initialInvestment.cents < 0 ||
        regularContribution.cents < 0 ||
        annualInterestRate < 0 ||
        investmentPeriodInYears <= 0) {
      return _zeroCalculation(
          initialInvestment,
          regularContribution,
          contributionFrequency,
          annualInterestRate,
          investmentPeriodInYears);
    }

    final double rate = annualInterestRate / 100;
    int contributionsPerYear;
    switch (contributionFrequency) {
      case ContributionFrequency.monthly:
        contributionsPerYear = 12;
        break;
      case ContributionFrequency.quarterly:
        contributionsPerYear = 4;
        break;
      case ContributionFrequency.annually:
        contributionsPerYear = 1;
        break;
    }

    final double effectiveRate = rate / contributionsPerYear;
    final int totalContributions = investmentPeriodInYears * contributionsPerYear;

    double futureValue = initialInvestment.dollars * pow(1 + effectiveRate, totalContributions).toDouble();

    if (effectiveRate == 0) {
      futureValue += regularContribution.dollars * totalContributions;
    } else {
      futureValue += regularContribution.dollars *
          ((pow(1 + effectiveRate, totalContributions) - 1) / effectiveRate);
    }
    
    final totalContributionsValue = initialInvestment + (regularContribution * totalContributions);
    final futureValueCents = MoneyCents.fromDollars(futureValue);
    final totalEarnings = futureValueCents - totalContributionsValue;

    return InvestmentCalculation(
      initialInvestment: initialInvestment,
      regularContribution: regularContribution,
      contributionFrequency: contributionFrequency,
      annualInterestRate: annualInterestRate,
      investmentPeriodInYears: investmentPeriodInYears,
      futureValue: futureValueCents,
      totalContributions: totalContributionsValue,
      totalEarnings: totalEarnings,
    );
  }

  InvestmentCalculation _zeroCalculation(
      MoneyCents initialInvestment,
      MoneyCents regularContribution,
      ContributionFrequency contributionFrequency,
      double annualInterestRate,
      int investmentPeriodInYears) {
    return InvestmentCalculation(
      initialInvestment: initialInvestment,
      regularContribution: regularContribution,
      contributionFrequency: contributionFrequency,
      annualInterestRate: annualInterestRate,
      investmentPeriodInYears: investmentPeriodInYears,
      futureValue: MoneyCents.zero,
      totalContributions: MoneyCents.zero,
      totalEarnings: MoneyCents.zero,
    );
  }
}
