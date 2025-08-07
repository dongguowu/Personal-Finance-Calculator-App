import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finance_calculator/features/investment_calculator/domain/entities/investment_calculation.dart';
import 'package:personal_finance_calculator/features/investment_calculator/domain/usecases/calculate_investment_return_usecase.dart';
import 'package:personal_finance_calculator/core/share/money_cents.dart';

final investmentCalculatorProvider = StateNotifierProvider<InvestmentCalculatorNotifier, InvestmentCalculation?>((ref) {
  return InvestmentCalculatorNotifier(ref.watch(calculateInvestmentReturnUseCaseProvider));
});

final calculateInvestmentReturnUseCaseProvider = Provider((ref) => CalculateInvestmentReturnUseCase());

class InvestmentCalculatorNotifier extends StateNotifier<InvestmentCalculation?> {
  final CalculateInvestmentReturnUseCase _calculateInvestmentReturnUseCase;

  InvestmentCalculatorNotifier(this._calculateInvestmentReturnUseCase) : super(null);

  void calculate({
    required double initialInvestment,
    required double regularContribution,
    required String contributionFrequency,
    required double annualInterestRate,
    required int investmentPeriodInYears,
  }) {
    final initialInvestmentCents = MoneyCents.fromDollars(initialInvestment);
    final regularContributionCents = MoneyCents.fromDollars(regularContribution);
    
    ContributionFrequency frequency;
    switch (contributionFrequency) {
      case 'monthly':
        frequency = ContributionFrequency.monthly;
        break;
      case 'quarterly':
        frequency = ContributionFrequency.quarterly;
        break;
      case 'annually':
        frequency = ContributionFrequency.annually;
        break;
      default:
        frequency = ContributionFrequency.monthly;
    }

    final result = _calculateInvestmentReturnUseCase.call(
      initialInvestment: initialInvestmentCents,
      regularContribution: regularContributionCents,
      contributionFrequency: frequency,
      annualInterestRate: annualInterestRate,
      investmentPeriodInYears: investmentPeriodInYears,
    );
    state = result;
  }
}
