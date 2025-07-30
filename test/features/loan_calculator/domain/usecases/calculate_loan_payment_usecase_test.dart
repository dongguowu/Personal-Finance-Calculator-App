import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';
import 'package:personal_finance_calculator/features/loan_calculator/domain/usecases/calculate_loan_payment_usecase.dart';

void main() {
  group('CalculateLoanPaymentUseCase', () {
    late CalculateLoanPaymentUseCase useCase;

    setUp(() {
      useCase = CalculateLoanPaymentUseCase();
    });

    group('execute', () {
      test('calculates loan payment correctly for standard inputs', () {
        // Arrange
        const loanAmount = 100000.0;
        const annualInterestRate = 5.0;
        const loanTermYears = 30;

        // Act
        final result = useCase.execute(
          loanAmountDollars: loanAmount,
          annualInterestRate: annualInterestRate,
          loanTermYears: loanTermYears,
        );

        // Assert
        expect(result.loanAmountCents, equals(10000000)); // $100,000 in cents
        expect(result.annualInterestRate, equals(5.0));
        expect(result.loanTermYears, equals(30));
        
        // Monthly payment should be approximately $536.82
        expect(result.monthlyPaymentCents, inInclusiveRange(53680, 53685));
        expect(result.totalInterestCents, greaterThan(0));
        expect(result.totalRepaymentCents, equals(result.loanAmountCents + result.totalInterestCents));
      });

      test('handles zero interest rate correctly', () {
        // Arrange
        const loanAmount = 120000.0;
        const annualInterestRate = 0.0;
        const loanTermYears = 10;

        // Act
        final result = useCase.execute(
          loanAmountDollars: loanAmount,
          annualInterestRate: annualInterestRate,
          loanTermYears: loanTermYears,
        );

        // Assert
        expect(result.loanAmountCents, equals(12000000));
        expect(result.annualInterestRate, equals(0.0));
        expect(result.totalInterestCents, equals(0));
        
        // Monthly payment should be loan amount / total months
        final expectedMonthlyPayment = (12000000 / (10 * 12)).round();
        expect(result.monthlyPaymentCents, equals(expectedMonthlyPayment));
        expect(result.totalRepaymentCents, equals(12000000));
      });

      test('returns zero calculation for invalid loan amount', () {
        // Arrange
        const loanAmount = 0.0;
        const annualInterestRate = 5.0;
        const loanTermYears = 30;

        // Act
        final result = useCase.execute(
          loanAmountDollars: loanAmount,
          annualInterestRate: annualInterestRate,
          loanTermYears: loanTermYears,
        );

        // Assert
        expect(result.monthlyPaymentCents, equals(0));
        expect(result.totalInterestCents, equals(0));
        expect(result.totalRepaymentCents, equals(0));
      });

      test('returns zero calculation for negative loan amount', () {
        // Arrange
        const loanAmount = -10000.0;
        const annualInterestRate = 5.0;
        const loanTermYears = 30;

        // Act
        final result = useCase.execute(
          loanAmountDollars: loanAmount,
          annualInterestRate: annualInterestRate,
          loanTermYears: loanTermYears,
        );

        // Assert
        expect(result.monthlyPaymentCents, equals(0));
        expect(result.totalInterestCents, equals(0));
        expect(result.totalRepaymentCents, equals(0));
      });

      test('returns zero calculation for negative interest rate', () {
        // Arrange
        const loanAmount = 100000.0;
        const annualInterestRate = -1.0;
        const loanTermYears = 30;

        // Act
        final result = useCase.execute(
          loanAmountDollars: loanAmount,
          annualInterestRate: annualInterestRate,
          loanTermYears: loanTermYears,
        );

        // Assert
        expect(result.monthlyPaymentCents, equals(0));
        expect(result.totalInterestCents, equals(0));
        expect(result.totalRepaymentCents, equals(0));
      });

      test('returns zero calculation for invalid loan term', () {
        // Arrange
        const loanAmount = 100000.0;
        const annualInterestRate = 5.0;
        const loanTermYears = 0;

        // Act
        final result = useCase.execute(
          loanAmountDollars: loanAmount,
          annualInterestRate: annualInterestRate,
          loanTermYears: loanTermYears,
        );

        // Assert
        expect(result.monthlyPaymentCents, equals(0));
        expect(result.totalInterestCents, equals(0));
        expect(result.totalRepaymentCents, equals(0));
      });

      test('calculates correctly for high interest rate', () {
        // Arrange
        const loanAmount = 50000.0;
        const annualInterestRate = 15.0;
        const loanTermYears = 5;

        // Act
        final result = useCase.execute(
          loanAmountDollars: loanAmount,
          annualInterestRate: annualInterestRate,
          loanTermYears: loanTermYears,
        );

        // Assert
        expect(result.loanAmountCents, equals(5000000));
        expect(result.annualInterestRate, equals(15.0));
        expect(result.loanTermYears, equals(5));
        expect(result.monthlyPaymentCents, greaterThan(100000)); // > $1000/month
        expect(result.totalInterestCents, greaterThan(0));
      });

      test('calculates correctly for small loan amount', () {
        // Arrange
        const loanAmount = 1000.0;
        const annualInterestRate = 3.5;
        const loanTermYears = 2;

        // Act
        final result = useCase.execute(
          loanAmountDollars: loanAmount,
          annualInterestRate: annualInterestRate,
          loanTermYears: loanTermYears,
        );

        // Assert
        expect(result.loanAmountCents, equals(100000));
        expect(result.annualInterestRate, equals(3.5));
        expect(result.loanTermYears, equals(2));
        expect(result.monthlyPaymentCents, greaterThan(0));
        expect(result.totalRepaymentCents, greaterThan(result.loanAmountCents));
      });

      test('handles decimal precision correctly', () {
        // Arrange
        const loanAmount = 150000.99;
        const annualInterestRate = 4.25;
        const loanTermYears = 25;

        // Act
        final result = useCase.execute(
          loanAmountDollars: loanAmount,
          annualInterestRate: annualInterestRate,
          loanTermYears: loanTermYears,
        );

        // Assert
        expect(result.loanAmountCents, equals(15000099)); // Rounded to nearest cent
        expect(result.annualInterestRate, equals(4.25));
        expect(result.monthlyPaymentCents, greaterThan(0));
        expect(result.totalRepaymentCents, greaterThan(result.loanAmountCents));
      });
    });
  });
}