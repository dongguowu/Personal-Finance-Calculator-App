import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_finance_calculator/core/share/money_cents.dart';

part 'loan_calculation.freezed.dart';

@freezed
class LoanCalculation with _$LoanCalculation {
  const factory LoanCalculation({
    required MoneyCents loanAmount,
    required double annualInterestRate,
    required int loanTermInYears,
    required MoneyCents monthlyPayment,
    required MoneyCents totalInterestPaid,
    required MoneyCents totalRepayment,
  }) = _LoanCalculation;
}
