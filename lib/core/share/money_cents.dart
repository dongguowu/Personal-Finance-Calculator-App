import 'package:intl/intl.dart';

/// A class to handle monetary values with cent-based precision to avoid floating-point errors.
///
/// It stores money as an integer number of cents and provides methods for arithmetic,
/// comparison, and robust, localized formatting.
class MoneyCents implements Comparable<MoneyCents> {
  /// A constant for a zero value, useful for initializations and comparisons.
  static const MoneyCents zero = MoneyCents.fromCents(0);

  final int _cents;

  /// Creates a [MoneyCents] instance from a given number of cents.
  const MoneyCents.fromCents(this._cents);

  /// Creates a [MoneyCents] instance from a dollar value.
  ///
  /// The value is rounded to the nearest cent.
  MoneyCents.fromDollars(double dollars) : _cents = (dollars * 100).round();

  /// The value in cents (e.g., 1234 for $12.34).
  int get cents => _cents;

  /// The value in dollars (e.g., 12.34 for 1234 cents).
  double get dollars => _cents / 100.0;

  // --- Arithmetic Operators ---

  /// Adds two [MoneyCents] values.
  MoneyCents operator +(MoneyCents other) => MoneyCents.fromCents(_cents + other.cents);

  /// Subtracts one [MoneyCents] value from another.
  MoneyCents operator -(MoneyCents other) => MoneyCents.fromCents(_cents - other.cents);

  /// Multiplies a [MoneyCents] value by an integer.
  MoneyCents operator *(int multiplier) => MoneyCents.fromCents(_cents * multiplier);

  /// Divides a [MoneyCents] value by an integer, truncating any fractional part.
  MoneyCents operator ~/(int divisor) => MoneyCents.fromCents(_cents ~/ divisor);

  // --- Comparison & Equality ---

  @override
  int compareTo(MoneyCents other) => _cents.compareTo(other.cents);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyCents &&
          runtimeType == other.runtimeType &&
          _cents == other._cents;

  @override
  int get hashCode => _cents.hashCode;

  bool operator >(MoneyCents other) => _cents > other.cents;
  bool operator <(MoneyCents other) => _cents < other.cents;
  bool operator >=(MoneyCents other) => _cents >= other.cents;
  bool operator <=(MoneyCents other) => _cents <= other.cents;

  // --- Formatting ---

  /// Formats the value as a currency string (e.g., "CA$1,234.56").
  ///
  /// Uses the 'intl' package for proper localization and formatting.
  /// Defaults to a Canadian locale ('en_CA') and symbol ('CA$').
  String toFormattedCurrency({String locale = 'en_CA', String symbol = 'CA\$'}) {
    final format = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
    );
    return format.format(dollars);
  }

  /// Returns a string representation of the dollar value, fixed to two decimal places.
  @override
  String toString() => dollars.toStringAsFixed(2);
}
