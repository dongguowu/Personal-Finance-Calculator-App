import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';
import 'package:personal_finance_calculator/features/loan_calculator/presentation/widgets/loan_result_display.dart';

void main() {
  group('LoanResultDisplay', () {
    const testLoanCalculation = LoanCalculation(
      loanAmountCents: 10000000, // $100,000
      annualInterestRate: 5.0,
      loanTermYears: 30,
      monthlyPaymentCents: 53682, // $536.82
      totalInterestCents: 9325520, // $93,255.20
      totalRepaymentCents: 19325520, // $193,255.20
    );

    const zeroLoanCalculation = LoanCalculation(
      loanAmountCents: 0,
      annualInterestRate: 0.0,
      loanTermYears: 0,
      monthlyPaymentCents: 0,
      totalInterestCents: 0,
      totalRepaymentCents: 0,
    );

    Widget createWidgetUnderTest({LoanCalculation? loanCalculation}) {
      return MaterialApp(
        home: Scaffold(
          body: LoanResultDisplay(
            loanCalculation: loanCalculation,
          ),
        ),
      );
    }

    group('UI Elements', () {
      testWidgets('displays header and result labels', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.text('Calculation Results'), findsOneWidget);
        expect(find.text('Monthly Payment'), findsOneWidget);
        expect(find.text('Total Interest Paid'), findsOneWidget);
        expect(find.text('Total Repayment'), findsOneWidget);
      });

      testWidgets('displays appropriate icons', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byIcon(Icons.payment), findsOneWidget);
        expect(find.byIcon(Icons.trending_up), findsOneWidget);
        expect(find.byIcon(Icons.account_balance_wallet), findsOneWidget);
      });

      testWidgets('shows help text when no calculation provided', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.text('Enter valid loan details to see calculations'), findsOneWidget);
      });

      testWidgets('shows help text when calculation has zero values', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest(loanCalculation: zeroLoanCalculation));

        // Assert
        expect(find.text('Enter valid loan details to see calculations'), findsOneWidget);
      });
    });

    group('Value Display', () {
      testWidgets('displays default zero values when no calculation provided', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.text('\$0.00 CAD'), findsNWidgets(3)); // Should appear 3 times
      });

      testWidgets('displays calculated values correctly', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest(loanCalculation: testLoanCalculation));

        // Assert
        expect(find.text('\$536.82 CAD'), findsOneWidget); // Monthly payment
        expect(find.text('\$93,255.20 CAD'), findsOneWidget); // Total interest
        expect(find.text('\$193,255.20 CAD'), findsOneWidget); // Total repayment
      });

      testWidgets('formats currency correctly with commas', (WidgetTester tester) async {
        // Arrange
        const largeLoanCalculation = LoanCalculation(
          loanAmountCents: 500000000, // $5,000,000
          annualInterestRate: 4.5,
          loanTermYears: 30,
          monthlyPaymentCents: 253351, // $2,533.51
          totalInterestCents: 412066360, // $4,120,663.60
          totalRepaymentCents: 912066360, // $9,120,663.60
        );

        await tester.pumpWidget(createWidgetUnderTest(loanCalculation: largeLoanCalculation));

        // Assert
        expect(find.text('\$2,533.51 CAD'), findsOneWidget);
        expect(find.text('\$4,120,663.60 CAD'), findsOneWidget);
        expect(find.text('\$9,120,663.60 CAD'), findsOneWidget);
      });

      testWidgets('handles small values correctly', (WidgetTester tester) async {
        // Arrange
        const smallLoanCalculation = LoanCalculation(
          loanAmountCents: 100000, // $1,000
          annualInterestRate: 3.0,
          loanTermYears: 5,
          monthlyPaymentCents: 1796, // $17.96
          totalInterestCents: 7760, // $77.60
          totalRepaymentCents: 107760, // $1,077.60
        );

        await tester.pumpWidget(createWidgetUnderTest(loanCalculation: smallLoanCalculation));

        // Assert
        expect(find.text('\$17.96 CAD'), findsOneWidget);
        expect(find.text('\$77.60 CAD'), findsOneWidget);
        expect(find.text('\$1,077.60 CAD'), findsOneWidget);
      });

      testWidgets('displays zero values correctly', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest(loanCalculation: zeroLoanCalculation));

        // Assert
        expect(find.text('\$0.00 CAD'), findsNWidgets(3));
      });
    });

    group('Visual Styling', () {
      testWidgets('applies correct text styles to different elements', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest(loanCalculation: testLoanCalculation));
        await tester.pumpAndSettle();

        // Act
        final monthlyPaymentText = tester.widget<Text>(find.text('\$536.82 CAD'));
        final totalInterestText = tester.widget<Text>(find.text('\$93,255.20 CAD'));

        // Assert
        expect(monthlyPaymentText.style?.fontWeight, equals(FontWeight.bold));
        // The total interest and repayment should have different styling
        expect(totalInterestText.style?.fontWeight, isNot(equals(FontWeight.bold)));
      });

      testWidgets('displays results in card layout', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byType(Card), findsOneWidget);
      });
    });
  });
}
