import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';
import 'package:personal_finance_calculator/features/loan_calculator/domain/usecases/calculate_loan_payment_usecase.dart';
import 'package:personal_finance_calculator/core/share/money_cents.dart';

final loanCalculatorProvider = StateNotifierProvider<LoanCalculatorNotifier, LoanCalculation?>((ref) {
  return LoanCalculatorNotifier(ref.watch(calculateLoanPaymentUseCaseProvider));
});

final calculateLoanPaymentUseCaseProvider = Provider((ref) => CalculateLoanPaymentUseCase());

class LoanCalculatorNotifier extends StateNotifier<LoanCalculation?> {
  final CalculateLoanPaymentUseCase _calculateLoanPaymentUseCase;

  LoanCalculatorNotifier(this._calculateLoanPaymentUseCase) : super(null);

  void calculate({
    required double loanAmount,
    required double annualInterestRate,
    required int loanTermInYears,
  }) {
    final loanAmountCents = MoneyCents.fromDollars(loanAmount);
    final result = _calculateLoanPaymentUseCase.call(
      loanAmount: loanAmountCents,
      annualInterestRate: annualInterestRate,
      loanTermInYears: loanTermInYears,
    );
    state = result;
  }
}
