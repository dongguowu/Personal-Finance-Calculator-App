class MoneyCents {
  final int _cents;

  const MoneyCents.fromCents(this._cents);
  MoneyCents.fromDollars(double dollars) : _cents = (dollars * 100).round();

  int get cents => _cents;
  double get dollars => _cents / 100.0;

  MoneyCents operator +(MoneyCents other) => MoneyCents.fromCents(_cents + other._cents);
  MoneyCents operator -(MoneyCents other) => MoneyCents.fromCents(_cents - other._cents);
  MoneyCents operator *(double multiplier) =>
      MoneyCents.fromCents((_cents * multiplier).round());
  MoneyCents operator /(double divisor) =>
      MoneyCents.fromCents((_cents / divisor).round());

  bool operator >(MoneyCents other) => _cents > other._cents;
  bool operator <(MoneyCents other) => _cents < other._cents;
  bool operator >=(MoneyCents other) => _cents >= other._cents;
  bool operator <=(MoneyCents other) => _cents <= other._cents;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyCents &&
          runtimeType == other.runtimeType &&
          _cents == other._cents;

  @override
  int get hashCode => _cents.hashCode;

  @override
  String toString() => '\${dollars.toStringAsFixed(2)}';

  String toStringWithoutSymbol() => dollars.toStringAsFixed(2);
}
