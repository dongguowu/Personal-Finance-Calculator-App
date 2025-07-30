import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';
import 'package:personal_finance_calculator/features/loan_calculator/data/models/loan_calculation_model.dart';

void main() {
  group('LoanCalculationModel', () {
    const testLoanCalculation = LoanCalculation(
      loanAmountCents: 10000000, // $100,000
      annualInterestRate: 5.0,
      loanTermYears: 30,
      monthlyPaymentCents: 53682, // $536.82
      totalInterestCents: 9325520, // $93,255.20
      totalRepaymentCents: 19325520, // $193,255.20
    );

    const testMap = {
      'loan_amount_cents': 10000000,
      'annual_interest_rate': 5.0,
      'loan_term_years': 30,
      'monthly_payment_cents': 53682,
      'total_interest_cents': 9325520,
      'total_repayment_cents': 19325520,
    };

    group('toMap', () {
      test('converts LoanCalculation entity to map correctly', () {
        // Act
        final result = LoanCalculationModel.toMap(testLoanCalculation);

        // Assert
        expect(result, equals(testMap));
        expect(result['loan_amount_cents'], isA<int>());
        expect(result['annual_interest_rate'], isA<double>());
        expect(result['loan_term_years'], isA<int>());
        expect(result['monthly_payment_cents'], isA<int>());
        expect(result['total_interest_cents'], isA<int>());
        expect(result['total_repayment_cents'], isA<int>());
      });

      test('handles zero values correctly', () {
        // Arrange
        const zeroCalculation = LoanCalculation(
          loanAmountCents: 0,
          annualInterestRate: 0.0,
          loanTermYears: 1,
          monthlyPaymentCents: 0,
          totalInterestCents: 0,
          totalRepaymentCents: 0,
        );

        // Act
        final result = LoanCalculationModel.toMap(zeroCalculation);

        // Assert
        expect(result['loan_amount_cents'], equals(0));
        expect(result['annual_interest_rate'], equals(0.0));
        expect(result['monthly_payment_cents'], equals(0));
        expect(result['total_interest_cents'], equals(0));
        expect(result['total_repayment_cents'], equals(0));
      });
    });

    group('fromMap', () {
      test('converts map to LoanCalculation entity correctly', () {
        // Act
        final result = LoanCalculationModel.fromMap(testMap);

        // Assert
        expect(result.loanAmountCents, equals(testLoanCalculation.loanAmountCents));
        expect(result.annualInterestRate, equals(testLoanCalculation.annualInterestRate));
        expect(result.loanTermYears, equals(testLoanCalculation.loanTermYears));
        expect(result.monthlyPaymentCents, equals(testLoanCalculation.monthlyPaymentCents));
        expect(result.totalInterestCents, equals(testLoanCalculation.totalInterestCents));
        expect(result.totalRepaymentCents, equals(testLoanCalculation.totalRepaymentCents));
      });

      test('handles decimal interest rates correctly', () {
        // Arrange
        final mapWithDecimalRate = Map<String, dynamic>.from(testMap);
        mapWithDecimalRate['annual_interest_rate'] = 4.75;

        // Act
        final result = LoanCalculationModel.fromMap(mapWithDecimalRate);

        // Assert
        expect(result.annualInterestRate, equals(4.75));
      });

      test('throws when required keys are missing', () {
        // Arrange
        final incompleteMap = Map<String, dynamic>.from(testMap);
        incompleteMap.remove('loan_amount_cents');

        // Act & Assert
        expect(
          () => LoanCalculationModel.fromMap(incompleteMap),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('dollarsToCents', () {
      test('converts dollars to cents correctly', () {
        expect(LoanCalculationModel.dollarsToCents(100.00), equals(10000));
        expect(LoanCalculationModel.dollarsToCents(100.50), equals(10050));
        expect(LoanCalculationModel.dollarsToCents(0.01), equals(1));
        expect(LoanCalculationModel.dollarsToCents(0.00), equals(0));
      });

      test('rounds to nearest cent', () {
        expect(LoanCalculationModel.dollarsToCents(100.004), equals(10000));
        expect(LoanCalculationModel.dollarsToCents(100.005), equals(10001));
        expect(LoanCalculationModel.dollarsToCents(100.006), equals(10001));
      });

      test('handles large amounts correctly', () {
        expect(LoanCalculationModel.dollarsToCents(1000000.99), equals(100000099));
      });
    });

    group('centsToDollars', () {
      test('converts cents to dollars correctly', () {
        expect(LoanCalculationModel.centsToDollars(10000), equals(100.00));
        expect(LoanCalculationModel.centsToDollars(10050), equals(100.50));
        expect(LoanCalculationModel.centsToDollars(1), equals(0.01));
        expect(LoanCalculationModel.centsToDollars(0), equals(0.00));
      });

      test('handles large amounts correctly', () {
        expect(LoanCalculationModel.centsToDollars(100000099), equals(1000000.99));
      });
    });

    group('isValidMap', () {
      test('returns true for valid map', () {
        // Act
        final result = LoanCalculationModel.isValidMap(testMap);

        // Assert
        expect(result, isTrue);
      });

      test('returns false when required keys are missing', () {
        // Arrange
        final incompleteMap = Map<String, dynamic>.from(testMap);
        incompleteMap.remove('loan_amount_cents');

        // Act
        final result = LoanCalculationModel.isValidMap(incompleteMap);

        // Assert
        expect(result, isFalse);
      });

      test('returns false for empty map', () {
        // Act
        final result = LoanCalculationModel.isValidMap({});

        // Assert
        expect(result, isFalse);
      });

      test('returns true even with extra keys', () {
        // Arrange
        final mapWithExtraKeys = Map<String, dynamic>.from(testMap);
        mapWithExtraKeys['extra_key'] = 'extra_value';

        // Act
        final result = LoanCalculationModel.isValidMap(mapWithExtraKeys);

        // Assert
        expect(result, isTrue);
      });
    });

    group('round-trip conversion', () {
      test('maintains data integrity through toMap and fromMap conversion', () {
        // Act
        final map = LoanCalculationModel.toMap(testLoanCalculation);
        final reconstructed = LoanCalculationModel.fromMap(map);

        // Assert
        expect(reconstructed, equals(testLoanCalculation));
      });
    });
  });
}