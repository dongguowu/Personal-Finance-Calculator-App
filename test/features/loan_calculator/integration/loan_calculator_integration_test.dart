import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finance_calculator/features/loan_calculator/presentation/pages/loan_calculator_page.dart';

void main() {
  group('Loan Calculator Integration Tests', () {
    Widget createApp() {
      return const MaterialApp(
        home: LoanCalculatorPage(),
      );
    }

    group('Full Feature Flow', () {
      testWidgets('completes full calculation flow from input to display', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Assert initial state
        expect(find.text('Loan Calculator'), findsOneWidget);
        expect(find.text('Loan Details'), findsOneWidget);
        expect(find.text('Calculation Results'), findsOneWidget);
        expect(find.text('\$0.00 CAD'), findsNWidgets(3)); // All results should be zero initially

        // Act - Enter loan amount
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '100000',
        );
        await tester.pump();

        // Assert - Results should still be zero (incomplete input)
        expect(find.text('\$0.00 CAD'), findsNWidgets(3));

        // Act - Enter interest rate
        await tester.enterText(
          find.ancestor(
            of: find.text('Annual Interest Rate'),
            matching: find.byType(TextField),
          ),
          '5.0',
        );
        await tester.pump();

        // Assert - Results should still be zero (incomplete input)
        expect(find.text('\$0.00 CAD'), findsNWidgets(3));

        // Act - Enter loan term (complete all inputs)
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Term'),
            matching: find.byType(TextField),
          ),
          '30',
        );
        await tester.pump();

        // Assert - Results should now be calculated
        expect(find.text('\$0.00 CAD'), findsNothing);
        expect(find.textContaining('\$'), findsNWidgets(3)); // Should have 3 currency values
        expect(find.textContaining('CAD'), findsNWidgets(3)); // All should have CAD suffix
      });

      testWidgets('real-time calculation updates as inputs change', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Act - Enter complete valid inputs
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '50000',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Annual Interest Rate'),
            matching: find.byType(TextField),
          ),
          '4.5',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Term'),
            matching: find.byType(TextField),
          ),
          '15',
        );
        await tester.pump();

        // Get initial calculated values
        final monthlyPaymentFinder = find.textContaining('\$').first;
        final initialMonthlyPayment = tester.widget<Text>(monthlyPaymentFinder).data;

        // Act - Change loan amount
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '75000',
        );
        await tester.pump();

        // Assert - Values should have changed
        final newMonthlyPaymentFinder = find.textContaining('\$').first;
        final newMonthlyPayment = tester.widget<Text>(newMonthlyPaymentFinder).data;
        expect(newMonthlyPayment, isNot(equals(initialMonthlyPayment)));
      });

      testWidgets('handles zero interest rate correctly', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Act - Enter inputs with zero interest rate
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '120000',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Annual Interest Rate'),
            matching: find.byType(TextField),
          ),
          '0',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Term'),
            matching: find.byType(TextField),
          ),
          '10',
        );
        await tester.pump();

        // Assert - Should calculate with zero interest
        expect(find.text('\$0.00 CAD'), findsOneWidget); // Only total interest should be zero
        expect(find.text('\$1,000.00 CAD'), findsOneWidget); // Monthly payment should be $1000
        expect(find.text('\$120,000.00 CAD'), findsOneWidget); // Total repayment should equal principal
      });

      testWidgets('validates inputs and shows errors appropriately', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Act - Enter invalid loan amount
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '0',
        );
        await tester.pump();

        // Assert - Should show error
        expect(find.text('Loan amount must be greater than 0'), findsOneWidget);

        // Act - Enter valid loan amount but invalid interest rate
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
          '-1',
        );
        await tester.pump();

        // Assert - Should show interest rate error, loan amount error should be gone
        expect(find.text('Loan amount must be greater than 0'), findsNothing);
        expect(find.text('Interest rate must be 0 or greater'), findsOneWidget);

        // Act - Fix interest rate but enter invalid loan term
        await tester.enterText(
          find.ancestor(
            of: find.text('Annual Interest Rate'),
            matching: find.byType(TextField),
          ),
          '5',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Term'),
            matching: find.byType(TextField),
          ),
          '0',
        );
        await tester.pump();

        // Assert - Should show loan term error
        expect(find.text('Interest rate must be 0 or greater'), findsNothing);
        expect(find.text('Loan term must be greater than 0'), findsOneWidget);
      });
    });

    group('Edge Cases and Error Handling', () {
      testWidgets('clears results when inputs become invalid', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Act - Enter valid inputs first
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
          '5.0',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Term'),
            matching: find.byType(TextField),
          ),
          '30',
        );
        await tester.pump();

        // Assert - Should have calculated results
        expect(find.text('\$0.00 CAD'), findsNothing);

        // Act - Clear one input to make it invalid
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '',
        );
        await tester.pump();

        // Assert - Results should return to zero and show help text
        expect(find.text('\$0.00 CAD'), findsNWidgets(3));
        expect(find.text('Enter valid loan details to see calculations'), findsOneWidget);
      });

      testWidgets('handles very large numbers without overflow', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Act - Enter large loan amount
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '1000000',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Annual Interest Rate'),
            matching: find.byType(TextField),
          ),
          '7.5',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Term'),
            matching: find.byType(TextField),
          ),
          '30',
        );
        await tester.pump();

        // Assert - Should handle large numbers gracefully
        expect(find.textContaining('\$'), findsNWidgets(3));
        expect(find.textContaining('CAD'), findsNWidgets(3));
        // Should not throw any exceptions or show error states
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles decimal inputs correctly', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Act - Enter decimal values
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '125000.75',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Annual Interest Rate'),
            matching: find.byType(TextField),
          ),
          '4.25',
        );
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Term'),
            matching: find.byType(TextField),
          ),
          '25',
        );
        await tester.pump();

        // Assert - Should calculate with decimal precision
        expect(find.textContaining('\$'), findsNWidgets(3));
        expect(find.textContaining('CAD'), findsNWidgets(3));
        expect(tester.takeException(), isNull);
      });
    });

    group('UI Navigation and Layout', () {
      testWidgets('displays app bar with correct title', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('Loan Calculator'), findsOneWidget);
      });

      testWidgets('layout is scrollable for small screens', (WidgetTester tester) async {
        // Arrange - Set a small screen size
        tester.binding.window.physicalSizeTestValue = const Size(300, 600);
        tester.binding.window.devicePixelRatioTestValue = 1.0;
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);

        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Assert - Should have scrollable content
        expect(find.byType(SingleChildScrollView), findsOneWidget);
        
        // Should be able to scroll without overflow
        await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -200));
        await tester.pump();
        expect(tester.takeException(), isNull);
      });

      testWidgets('maintains input focus during calculation updates', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createApp());
        await tester.pumpAndSettle();

        // Act - Focus on loan amount field and enter values
        await tester.tap(find.ancestor(
          of: find.text('Loan Amount'),
          matching: find.byType(TextField),
        ));
        await tester.enterText(
          find.ancestor(
            of: find.text('Loan Amount'),
            matching: find.byType(TextField),
          ),
          '100000',
        );
        await tester.pump();

        // Assert - Field should still be focused
        final textField = tester.widget<TextField>(find.ancestor(
          of: find.text('Loan Amount'),
          matching: find.byType(TextField),
        ));
        expect(textField.focusNode?.hasFocus, isTrue);
      });
    });
  });
}