import 'package:personal_finance_calculator/core/share/money_cents.dart';
import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';
import 'dart:math';

class CalculateLoanPaymentUseCase {
  LoanCalculation call({
    required MoneyCents loanAmount,
    required double annualInterestRate,
    required int loanTermInYears,
  }) {
    if (loanAmount.cents <= 0 || annualInterestRate < 0 || loanTermInYears <= 0) {
      return LoanCalculation(
        loanAmount: loanAmount,
        annualInterestRate: annualInterestRate,
        loanTermInYears: loanTermInYears,
        monthlyPayment: MoneyCents.zero,
        totalInterestPaid: MoneyCents.zero,
        totalRepayment: MoneyCents.zero,
      );
    }

    final double monthlyInterestRate = annualInterestRate / 12 / 100;
    final int numberOfPayments = loanTermInYears * 12;

    if (monthlyInterestRate == 0) {
      final monthlyPayment = loanAmount ~/ numberOfPayments;
      return LoanCalculation(
        loanAmount: loanAmount,
        annualInterestRate: annualInterestRate,
        loanTermInYears: loanTermInYears,
        monthlyPayment: monthlyPayment,
        totalInterestPaid: MoneyCents.zero,
        totalRepayment: loanAmount,
      );
    }
    
    final double monthlyPaymentValue = loanAmount.dollars *
        (monthlyInterestRate * pow(1 + monthlyInterestRate, numberOfPayments)) /
        (pow(1 + monthlyInterestRate, numberOfPayments) - 1);

    final monthlyPayment = MoneyCents.fromDollars(monthlyPaymentValue);
    final totalRepayment = monthlyPayment * numberOfPayments;
    final totalInterestPaid = totalRepayment - loanAmount;

    return LoanCalculation(
      loanAmount: loanAmount,
      annualInterestRate: annualInterestRate,
      loanTermInYears: loanTermInYears,
      monthlyPayment: monthlyPayment,
      totalInterestPaid: totalInterestPaid,
      totalRepayment: totalRepayment,
    );
  }
}
