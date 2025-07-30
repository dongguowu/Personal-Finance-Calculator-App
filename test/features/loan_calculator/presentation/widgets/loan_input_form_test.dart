import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finance_calculator/features/loan_calculator/presentation/widgets/loan_input_form.dart';

void main() {
  group('LoanInputForm', () {
    late bool onInputChangedCalled;
    late Map<String, dynamic> lastInputValues;

    void mockOnInputChanged({
      double? loanAmount,
      double? annualInterestRate,
      int? loanTermYears,
    }) {
      onInputChangedCalled = true;
      lastInputValues = {
        'loanAmount': loanAmount,
        'annualInterestRate': annualInterestRate,
        'loanTermYears': loanTermYears,
      };
    }

    setUp(() {
      onInputChangedCalled = false;
      lastInputValues = {};
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Scaffold(
          body: LoanInputForm(
            onInputChanged: mockOnInputChanged,
          ),
        ),
      );
    }

    group('UI Elements', () {
      testWidgets('displays all required input fields', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.text('Loan Details'), findsOneWidget);
        expect(find.text('Loan Amount'), findsOneWidget);
        expect(find.text('Annual Interest Rate'), findsOneWidget);
        expect(find.text('Loan Term'), findsOneWidget);
      });

      testWidgets('displays correct prefixes and suffixes', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.text('\$ '), findsOneWidget); // Loan amount prefix
        expect(find.text('CAD'), findsOneWidget); // Loan amount suffix
        expect(find.text('%'), findsOneWidget); // Interest rate suffix
        expect(find.text('Years'), findsOneWidget); // Loan term suffix
      });

      testWidgets('displays helper texts', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.text('Enter the total loan amount'), findsOneWidget);
        expect(find.text('Enter the annual interest rate (e.g., 5.25)'), findsOneWidget);
        expect(find.text('Enter the loan term in years'), findsOneWidget);
      });
    });

    group('Input Validation', () {
      testWidgets('shows error for invalid loan amount', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());
        final loanAmountField = find.byKey(const Key('loan_amount_field'));

        // Act
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '0',
        );
        await tester.pump();

        // Assert
        expect(find.text('Loan amount must be greater than 0'), findsOneWidget);
      });

      testWidgets('shows error for negative interest rate', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Act
        await tester.enterText(
          find.ancestor(
            of: find.text('Annual Interest Rate'),
            matching: find.byType(TextField),
          ),
          '-1',
        );
        await tester.pump();

        // Assert
        expect(find.text('Interest rate must be 0 or greater'), findsOneWidget);
      });

      testWidgets('shows error for invalid loan term', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Act
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Term'),
            matching: find.byType(TextField),
          ),
          '0',
        );
        await tester.pump();

        // Assert
        expect(find.text('Loan term must be greater than 0'), findsOneWidget);
      });

      testWidgets('accepts valid inputs without errors', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Act
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '100000',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Annual Interest Rate'),
            matching: find.byType(TextField),
          ),
          '5.25',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Term'),
            matching: find.byType(TextField),
          ),
          '30',
        );
        await tester.pump();

        // Assert
        expect(find.text('Loan amount must be greater than 0'), findsNothing);
        expect(find.text('Interest rate must be 0 or greater'), findsNothing);
        expect(find.text('Loan term must be greater than 0'), findsNothing);
      });
    });

    group('Input Callbacks', () {
      testWidgets('calls onInputChanged when loan amount changes', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Act
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '150000',
        );

        // Assert
        expect(onInputChangedCalled, isTrue);
        expect(lastInputValues['loanAmount'], equals(150000.0));
      });

      testWidgets('calls onInputChanged when interest rate changes', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Act
        await tester.enterText(
          find.ancestor(
            of: find.text('Annual Interest Rate'),
            matching: find.byType(TextField),
          ),
          '4.75',
        );

        // Assert
        expect(onInputChangedCalled, isTrue);
        expect(lastInputValues['annualInterestRate'], equals(4.75));
      });

      testWidgets('calls onInputChanged when loan term changes', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Act
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Term'),
            matching: find.byType(TextField),
          ),
          '25',
        );

        // Assert
        expect(onInputChangedCalled, isTrue);
        expect(lastInputValues['loanTermYears'], equals(25));
      });

      testWidgets('passes null values for empty inputs', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Act - Enter and then clear the loan amount
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '100000',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '',
        );

        // Assert
        expect(onInputChangedCalled, isTrue);
        expect(lastInputValues['loanAmount'], isNull);
      });

      testWidgets('handles decimal inputs correctly', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Act
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '123456.78',
        );

        // Assert
        expect(onInputChangedCalled, isTrue);
        expect(lastInputValues['loanAmount'], equals(123456.78));
      });
    });

    group('Input Formatting', () {
      testWidgets('allows decimal input for loan amount', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Act
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '100000.50',
        );

        // Assert
        final textField = tester.widget<TextField>(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
        );
        expect(textField.controller?.text, equals('100000.50'));
      });

      testWidgets('allows only digits for loan term', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest());

        // Act
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Term'),
            matching: find.byType(TextField),
          ),
          '30.5',
        );

        // Assert - Should only accept the digits
        final textField = tester.widget<TextField>(
          find.ancestor(
            of: find.text('Loan Term'),
            matching: find.byType(TextField),
          ),
        );
        expect(textField.controller?.text, equals('305')); // Decimal point filtered out
      });
    });
  });
}