import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finance_calculator/core/share/money_cents.dart';

// Test Numbering Convention & Description Guidelines
// -------------------------------------------------
// This test suite follows a structured numbering and description format to enhance clarity and organization.
//
// 1. Group Numbering (#N000):
//    - #1000: Construction & Initialization
//    - #2000: Arithmetic Operations
//    - #3000: Comparison & Equality
//    - #4000: Formatting
//
// 2. Test Numbering (#N0XX):
//    - Each test is prefixed with a number corresponding to its group (e.g., #1001, #1002).
//
// 3. Test Structure (Arrange/Act/Assert):
//    - Test bodies are structured with comments to clearly separate setup, execution, and verification steps.

void main() {
  group('MoneyCents', () {
    group('#1000: Constructors and Getters', () {
      test('#1001: fromCents constructor should store the correct cent value', () {
        // Arrange
        const money = MoneyCents.fromCents(12345);
        // Act & Assert
        expect(money.cents, 12345);
      });

      test('#1002: fromDollars constructor should correctly convert dollars to cents', () {
        // Arrange
        final money = MoneyCents.fromDollars(123.45);
        // Act & Assert
        expect(money.cents, 12345);
      });

      test('#1003: fromDollars constructor should round correctly', () {
        // Arrange
        final moneyUp = MoneyCents.fromDollars(123.456);
        final moneyDown = MoneyCents.fromDollars(123.454);
        // Act & Assert
        expect(moneyUp.cents, 12346, reason: 'Should round up');
        expect(moneyDown.cents, 12345, reason: 'Should round down');
      });

      test('#1004: dollars getter should return the correct dollar value', () {
        // Arrange
        const money = MoneyCents.fromCents(12345);
        // Act & Assert
        expect(money.dollars, 123.45);
      });

      test('#1005: zero constant should have a value of 0 cents', () {
        // Arrange & Act & Assert
        expect(MoneyCents.zero.cents, 0);
      });
    });

    group('#2000: Arithmetic Operators', () {
      // Arrange
      const moneyA = MoneyCents.fromCents(1000); // $10.00
      const moneyB = MoneyCents.fromCents(550);  // $5.50

      test('#2001: addition (+) should return the correct sum', () {
        // Act
        final result = moneyA + moneyB;
        // Assert
        expect(result.cents, 1550);
      });

      test('#2002: subtraction (-) should return the correct difference', () {
        // Act
        final result = moneyA - moneyB;
        // Assert
        expect(result.cents, 450);
      });

      test('#2003: integer multiplication (*) should return the correct product', () {
        // Act
        final result = moneyB * 3;
        // Assert
        expect(result.cents, 1650);
      });

      test('#2004: truncating division (~/) should return the correct value', () {
        // Act
        final result = moneyA ~/ 3;
        // Assert
        expect(result.cents, 333);
      });
    });

    group('#3000: Comparison and Equality', () {
      // Arrange
      const money100 = MoneyCents.fromCents(100);
      const money100b = MoneyCents.fromCents(100);
      const money200 = MoneyCents.fromCents(200);

      test('#3001: == operator should correctly check for equality', () {
        // Act & Assert
        expect(money100 == money100b, isTrue);
        expect(money100 == money200, isFalse);
      });

      test('#3002: hashCode should be equal for equal objects', () {
        // Act & Assert
        expect(money100.hashCode, money100b.hashCode);
        expect(money100.hashCode, isNot(money200.hashCode));
      });

      test('#3003: compareTo should return 0 for equal values', () {
        // Act & Assert
        expect(money100.compareTo(money100b), 0);
      });

      test('#3004: compareTo should return -1 if this is less than other', () {
        // Act & Assert
        expect(money100.compareTo(money200), -1);
      });

      test('#3005: compareTo should return 1 if this is greater than other', () {
        // Act & Assert
        expect(money200.compareTo(money100), 1);
      });

      test('#3006: > operator should work correctly', () {
        // Act & Assert
        expect(money200 > money100, isTrue);
        expect(money100 > money200, isFalse);
      });

      test('#3007: < operator should work correctly', () {
        // Act & Assert
        expect(money100 < money200, isTrue);
        expect(money200 < money100, isFalse);
      });

      test('#3008: >= operator should work correctly', () {
        // Act & Assert
        expect(money200 >= money100, isTrue);
        expect(money100 >= money100b, isTrue);
        expect(money100 >= money200, isFalse);
      });

      test('#3009: <= operator should work correctly', () {
        // Act & Assert
        expect(money100 <= money200, isTrue);
        expect(money100 <= money100b, isTrue);
        expect(money200 <= money100, isFalse);
      });
    });

    group('#4000: Formatting', () {
      // Arrange
      const money = MoneyCents.fromCents(123456); // $1,234.56

      test('#4001: toString() should return a plain string with two decimal places', () {
        // Act & Assert
        expect(money.toString(), '1234.56');
      });

      test('#4002: toFormattedCurrency should format correctly with default CA locale', () {
        // Act
        final formatted = money.toFormattedCurrency();
        // Assert
        expect(formatted.contains('1,234.56'), isTrue);
        expect(formatted.contains('\$'), isTrue);
      });

      test('#4003: toFormattedCurrency should respect custom locale and symbol', () {
        // Act
        final formatted = money.toFormattedCurrency(locale: 'de_DE', symbol: '€');
        // Assert
        expect(formatted.contains('1.234,56'), isTrue);
        expect(formatted.contains('€'), isTrue);
      });
    });
  });
}
