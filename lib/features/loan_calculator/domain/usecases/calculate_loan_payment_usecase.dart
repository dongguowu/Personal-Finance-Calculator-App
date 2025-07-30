import 'dart:math';
import '../entities/loan_calculation.dart';

/// Use case for calculating loan payment details including monthly payment,
/// total interest, and total repayment amount.
class CalculateLoanPaymentUseCase {
  /// Calculates loan payment details from input parameters.
  /// 
  /// Returns a [LoanCalculation] with all calculated values.
  /// If inputs are invalid, returns a calculation with zero values.
  /// 
  /// [loanAmountDollars] - Principal loan amount in dollars
  /// [annualInterestRate] - Annual interest rate as percentage (e.g., 5.25)
  /// [loanTermYears] - Loan term in years
  LoanCalculation execute({
    required double loanAmountDollars,
    required double annualInterestRate,
    required int loanTermYears,
  }) {
    // Input validation
    if (loanAmountDollars <= 0 || annualInterestRate < 0 || loanTermYears <= 0) {
      return _createZeroCalculation(
        loanAmountDollars: loanAmountDollars,
        annualInterestRate: annualInterestRate,
        loanTermYears: loanTermYears,
      );
    }

    // Convert loan amount to cents for precision
    final loanAmountCents = (loanAmountDollars * 100).round();

    // Handle zero interest rate case
    if (annualInterestRate == 0) {
      return _calculateZeroInterestLoan(
        loanAmountCents: loanAmountCents,
        annualInterestRate: annualInterestRate,
        loanTermYears: loanTermYears,
      );
    }

    // Standard loan calculation with interest
    return _calculateStandardLoan(
      loanAmountCents: loanAmountCents,
      annualInterestRate: annualInterestRate,
      loanTermYears: loanTermYears,
    );
  }

  /// Creates a LoanCalculation with zero values for invalid inputs
  LoanCalculation _createZeroCalculation({
    required double loanAmountDollars,
    required double annualInterestRate,
    required int loanTermYears,
  }) {
    return LoanCalculation(
      loanAmountCents: (loanAmountDollars * 100).round(),
      annualInterestRate: annualInterestRate,
      loanTermYears: loanTermYears,
      monthlyPaymentCents: 0,
      totalInterestCents: 0,
      totalRepaymentCents: 0,
    );
  }

  /// Calculates loan payment for zero interest rate
  LoanCalculation _calculateZeroInterestLoan({
    required int loanAmountCents,
    required double annualInterestRate,
    required int loanTermYears,
  }) {
    final totalMonths = loanTermYears * 12;
    final monthlyPaymentCents = (loanAmountCents / totalMonths).round();
    
    return LoanCalculation(
      loanAmountCents: loanAmountCents,
      annualInterestRate: annualInterestRate,
      loanTermYears: loanTermYears,
      monthlyPaymentCents: monthlyPaymentCents,
      totalInterestCents: 0,
      totalRepaymentCents: loanAmountCents,
    );
  }

  /// Calculates standard loan payment with interest using the standard formula
  LoanCalculation _calculateStandardLoan({
    required int loanAmountCents,
    required double annualInterestRate,
    required int loanTermYears,
  }) {
    // Convert to monthly interest rate and number of payments
    final monthlyInterestRate = annualInterestRate / 100 / 12;
    final totalMonths = loanTermYears * 12;
    
    // Calculate monthly payment using standard loan formula:
    // M = P * [r(1+r)^n] / [(1+r)^n - 1]
    // where M = monthly payment, P = principal, r = monthly rate, n = months
    final rateCompounded = pow(1 + monthlyInterestRate, totalMonths);
    final monthlyPaymentDollars = (loanAmountCents / 100) * 
        (monthlyInterestRate * rateCompounded) / 
        (rateCompounded - 1);
    
    final totalRepaymentCents = (monthlyPaymentDollars * totalMonths * 100).round();
    final monthlyPaymentCents = (totalRepaymentCents / totalMonths).round();
    final totalInterestCents = totalRepaymentCents - loanAmountCents;

    return LoanCalculation(
      loanAmountCents: loanAmountCents,
      annualInterestRate: annualInterestRate,
      loanTermYears: loanTermYears,
      monthlyPaymentCents: monthlyPaymentCents,
      totalInterestCents: totalInterestCents,
      totalRepaymentCents: totalRepaymentCents,
    );
  }
}