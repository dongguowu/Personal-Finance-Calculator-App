import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';
import 'package:personal_finance_calculator/core/share/money_cents.dart';

part 'loan_calculation_model.freezed.dart';
part 'loan_calculation_model.g.dart';

@freezed
class LoanCalculationModel with _$LoanCalculationModel {
  const LoanCalculationModel._();

  const factory LoanCalculationModel({
    required int loanAmount,
    required double annualInterestRate,
    required int loanTermInYears,
    required int monthlyPayment,
    required int totalInterestPaid,
    required int totalRepayment,
  }) = _LoanCalculationModel;

  factory LoanCalculationModel.fromDomain(LoanCalculation domain) {
    return LoanCalculationModel(
      loanAmount: domain.loanAmount.cents,
      annualInterestRate: domain.annualInterestRate,
      loanTermInYears: domain.loanTermInYears,
      monthlyPayment: domain.monthlyPayment.cents,
      totalInterestPaid: domain.totalInterestPaid.cents,
      totalRepayment: domain.totalRepayment.cents,
    );
  }

  LoanCalculation toDomain() {
    return LoanCalculation(
      loanAmount: MoneyCents.fromCents(loanAmount),
      annualInterestRate: annualInterestRate,
      loanTermInYears: loanTermInYears,
      monthlyPayment: MoneyCents.fromCents(monthlyPayment),
      totalInterestPaid: MoneyCents.fromCents(totalInterestPaid),
      totalRepayment: MoneyCents.fromCents(totalRepayment),
    );
  }

  factory LoanCalculationModel.fromJson(Map<String, dynamic> json) =>
      _$LoanCalculationModelFromJson(json);
}
