import '../../domain/entities/loan_calculation.dart';

/// Model class for converting LoanCalculation entity to/from database map representation
class LoanCalculationModel {
  /// Converts a LoanCalculation entity to a map for database storage
  static Map<String, dynamic> toMap(LoanCalculation loanCalculation) {
    return {
      'loan_amount_cents': loanCalculation.loanAmountCents,
      'annual_interest_rate': loanCalculation.annualInterestRate,
      'loan_term_years': loanCalculation.loanTermYears,
      'monthly_payment_cents': loanCalculation.monthlyPaymentCents,
      'total_interest_cents': loanCalculation.totalInterestCents,
      'total_repayment_cents': loanCalculation.totalRepaymentCents,
    };
  }

  /// Converts a database map to a LoanCalculation entity
  static LoanCalculation fromMap(Map<String, dynamic> map) {
    return LoanCalculation(
      loanAmountCents: map['loan_amount_cents'] as int,
      annualInterestRate: map['annual_interest_rate'] as double,
      loanTermYears: map['loan_term_years'] as int,
      monthlyPaymentCents: map['monthly_payment_cents'] as int,
      totalInterestCents: map['total_interest_cents'] as int,
      totalRepaymentCents: map['total_repayment_cents'] as int,
    );
  }

  /// Converts dollars to cents for storage
  static int dollarsToCents(double dollars) {
    return (dollars * 100).round();
  }

  /// Converts cents to dollars for display
  static double centsToDollars(int cents) {
    return cents / 100.0;
  }

  /// Validates that a map contains all required keys for LoanCalculation
  static bool isValidMap(Map<String, dynamic> map) {
    const requiredKeys = {
      'loan_amount_cents',
      'annual_interest_rate',
      'loan_term_years',
      'monthly_payment_cents',
      'total_interest_cents',
      'total_repayment_cents',
    };

    return requiredKeys.every((key) => map.containsKey(key));
  }
}