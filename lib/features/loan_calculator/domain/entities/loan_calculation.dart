/// Entity representing a loan calculation with all relevant financial data.
/// All monetary values are stored as integers representing cents to avoid
/// floating-point precision issues.
class LoanCalculation {
  /// Loan amount in cents
  final int loanAmountCents;
  
  /// Annual interest rate as a percentage (e.g., 5.25 for 5.25%)
  final double annualInterestRate;
  
  /// Loan term in years
  final int loanTermYears;
  
  /// Monthly payment amount in cents
  final int monthlyPaymentCents;
  
  /// Total interest paid over the loan term in cents
  final int totalInterestCents;
  
  /// Total repayment amount in cents
  final int totalRepaymentCents;

  const LoanCalculation({
    required this.loanAmountCents,
    required this.annualInterestRate,
    required this.loanTermYears,
    required this.monthlyPaymentCents,
    required this.totalInterestCents,
    required this.totalRepaymentCents,
  });

  /// Creates a copy of this LoanCalculation with optionally updated values
  LoanCalculation copyWith({
    int? loanAmountCents,
    double? annualInterestRate,
    int? loanTermYears,
    int? monthlyPaymentCents,
    int? totalInterestCents,
    int? totalRepaymentCents,
  }) {
    return LoanCalculation(
      loanAmountCents: loanAmountCents ?? this.loanAmountCents,
      annualInterestRate: annualInterestRate ?? this.annualInterestRate,
      loanTermYears: loanTermYears ?? this.loanTermYears,
      monthlyPaymentCents: monthlyPaymentCents ?? this.monthlyPaymentCents,
      totalInterestCents: totalInterestCents ?? this.totalInterestCents,
      totalRepaymentCents: totalRepaymentCents ?? this.totalRepaymentCents,
    );
  }

  /// Converts loan amount from cents to dollars
  double get loanAmountDollars => loanAmountCents / 100.0;
  
  /// Converts monthly payment from cents to dollars
  double get monthlyPaymentDollars => monthlyPaymentCents / 100.0;
  
  /// Converts total interest from cents to dollars
  double get totalInterestDollars => totalInterestCents / 100.0;
  
  /// Converts total repayment from cents to dollars
  double get totalRepaymentDollars => totalRepaymentCents / 100.0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is LoanCalculation &&
        other.loanAmountCents == loanAmountCents &&
        other.annualInterestRate == annualInterestRate &&
        other.loanTermYears == loanTermYears &&
        other.monthlyPaymentCents == monthlyPaymentCents &&
        other.totalInterestCents == totalInterestCents &&
        other.totalRepaymentCents == totalRepaymentCents;
  }

  @override
  int get hashCode {
    return Object.hash(
      loanAmountCents,
      annualInterestRate,
      loanTermYears,
      monthlyPaymentCents,
      totalInterestCents,
      totalRepaymentCents,
    );
  }

  @override
  String toString() {
    return 'LoanCalculation('
        'loanAmountCents: $loanAmountCents, '
        'annualInterestRate: $annualInterestRate, '
        'loanTermYears: $loanTermYears, '
        'monthlyPaymentCents: $monthlyPaymentCents, '
        'totalInterestCents: $totalInterestCents, '
        'totalRepaymentCents: $totalRepaymentCents)';
  }
}