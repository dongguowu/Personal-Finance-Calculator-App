// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loan_calculation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoanCalculation {
  MoneyCents get loanAmount => throw _privateConstructorUsedError;
  double get annualInterestRate => throw _privateConstructorUsedError;
  int get loanTermInYears => throw _privateConstructorUsedError;
  MoneyCents get monthlyPayment => throw _privateConstructorUsedError;
  MoneyCents get totalInterestPaid => throw _privateConstructorUsedError;
  MoneyCents get totalRepayment => throw _privateConstructorUsedError;

  /// Create a copy of LoanCalculation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoanCalculationCopyWith<LoanCalculation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoanCalculationCopyWith<$Res> {
  factory $LoanCalculationCopyWith(
          LoanCalculation value, $Res Function(LoanCalculation) then) =
      _$LoanCalculationCopyWithImpl<$Res, LoanCalculation>;
  @useResult
  $Res call(
      {MoneyCents loanAmount,
      double annualInterestRate,
      int loanTermInYears,
      MoneyCents monthlyPayment,
      MoneyCents totalInterestPaid,
      MoneyCents totalRepayment});
}

/// @nodoc
class _$LoanCalculationCopyWithImpl<$Res, $Val extends LoanCalculation>
    implements $LoanCalculationCopyWith<$Res> {
  _$LoanCalculationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoanCalculation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loanAmount = null,
    Object? annualInterestRate = null,
    Object? loanTermInYears = null,
    Object? monthlyPayment = null,
    Object? totalInterestPaid = null,
    Object? totalRepayment = null,
  }) {
    return _then(_value.copyWith(
      loanAmount: null == loanAmount
          ? _value.loanAmount
          : loanAmount // ignore: cast_nullable_to_non_nullable
              as MoneyCents,
      annualInterestRate: null == annualInterestRate
          ? _value.annualInterestRate
          : annualInterestRate // ignore: cast_nullable_to_non_nullable
              as double,
      loanTermInYears: null == loanTermInYears
          ? _value.loanTermInYears
          : loanTermInYears // ignore: cast_nullable_to_non_nullable
              as int,
      monthlyPayment: null == monthlyPayment
          ? _value.monthlyPayment
          : monthlyPayment // ignore: cast_nullable_to_non_nullable
              as MoneyCents,
      totalInterestPaid: null == totalInterestPaid
          ? _value.totalInterestPaid
          : totalInterestPaid // ignore: cast_nullable_to_non_nullable
              as MoneyCents,
      totalRepayment: null == totalRepayment
          ? _value.totalRepayment
          : totalRepayment // ignore: cast_nullable_to_non_nullable
              as MoneyCents,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoanCalculationImplCopyWith<$Res>
    implements $LoanCalculationCopyWith<$Res> {
  factory _$$LoanCalculationImplCopyWith(_$LoanCalculationImpl value,
          $Res Function(_$LoanCalculationImpl) then) =
      __$$LoanCalculationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MoneyCents loanAmount,
      double annualInterestRate,
      int loanTermInYears,
      MoneyCents monthlyPayment,
      MoneyCents totalInterestPaid,
      MoneyCents totalRepayment});
}

/// @nodoc
class __$$LoanCalculationImplCopyWithImpl<$Res>
    extends _$LoanCalculationCopyWithImpl<$Res, _$LoanCalculationImpl>
    implements _$$LoanCalculationImplCopyWith<$Res> {
  __$$LoanCalculationImplCopyWithImpl(
      _$LoanCalculationImpl _value, $Res Function(_$LoanCalculationImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoanCalculation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loanAmount = null,
    Object? annualInterestRate = null,
    Object? loanTermInYears = null,
    Object? monthlyPayment = null,
    Object? totalInterestPaid = null,
    Object? totalRepayment = null,
  }) {
    return _then(_$LoanCalculationImpl(
      loanAmount: null == loanAmount
          ? _value.loanAmount
          : loanAmount // ignore: cast_nullable_to_non_nullable
              as MoneyCents,
      annualInterestRate: null == annualInterestRate
          ? _value.annualInterestRate
          : annualInterestRate // ignore: cast_nullable_to_non_nullable
              as double,
      loanTermInYears: null == loanTermInYears
          ? _value.loanTermInYears
          : loanTermInYears // ignore: cast_nullable_to_non_nullable
              as int,
      monthlyPayment: null == monthlyPayment
          ? _value.monthlyPayment
          : monthlyPayment // ignore: cast_nullable_to_non_nullable
              as MoneyCents,
      totalInterestPaid: null == totalInterestPaid
          ? _value.totalInterestPaid
          : totalInterestPaid // ignore: cast_nullable_to_non_nullable
              as MoneyCents,
      totalRepayment: null == totalRepayment
          ? _value.totalRepayment
          : totalRepayment // ignore: cast_nullable_to_non_nullable
              as MoneyCents,
    ));
  }
}

/// @nodoc

class _$LoanCalculationImpl implements _LoanCalculation {
  const _$LoanCalculationImpl(
      {required this.loanAmount,
      required this.annualInterestRate,
      required this.loanTermInYears,
      required this.monthlyPayment,
      required this.totalInterestPaid,
      required this.totalRepayment});

  @override
  final MoneyCents loanAmount;
  @override
  final double annualInterestRate;
  @override
  final int loanTermInYears;
  @override
  final MoneyCents monthlyPayment;
  @override
  final MoneyCents totalInterestPaid;
  @override
  final MoneyCents totalRepayment;

  @override
  String toString() {
    return 'LoanCalculation(loanAmount: $loanAmount, annualInterestRate: $annualInterestRate, loanTermInYears: $loanTermInYears, monthlyPayment: $monthlyPayment, totalInterestPaid: $totalInterestPaid, totalRepayment: $totalRepayment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoanCalculationImpl &&
            (identical(other.loanAmount, loanAmount) ||
                other.loanAmount == loanAmount) &&
            (identical(other.annualInterestRate, annualInterestRate) ||
                other.annualInterestRate == annualInterestRate) &&
            (identical(other.loanTermInYears, loanTermInYears) ||
                other.loanTermInYears == loanTermInYears) &&
            (identical(other.monthlyPayment, monthlyPayment) ||
                other.monthlyPayment == monthlyPayment) &&
            (identical(other.totalInterestPaid, totalInterestPaid) ||
                other.totalInterestPaid == totalInterestPaid) &&
            (identical(other.totalRepayment, totalRepayment) ||
                other.totalRepayment == totalRepayment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loanAmount, annualInterestRate,
      loanTermInYears, monthlyPayment, totalInterestPaid, totalRepayment);

  /// Create a copy of LoanCalculation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoanCalculationImplCopyWith<_$LoanCalculationImpl> get copyWith =>
      __$$LoanCalculationImplCopyWithImpl<_$LoanCalculationImpl>(
          this, _$identity);
}

abstract class _LoanCalculation implements LoanCalculation {
  const factory _LoanCalculation(
      {required final MoneyCents loanAmount,
      required final double annualInterestRate,
      required final int loanTermInYears,
      required final MoneyCents monthlyPayment,
      required final MoneyCents totalInterestPaid,
      required final MoneyCents totalRepayment}) = _$LoanCalculationImpl;

  @override
  MoneyCents get loanAmount;
  @override
  double get annualInterestRate;
  @override
  int get loanTermInYears;
  @override
  MoneyCents get monthlyPayment;
  @override
  MoneyCents get totalInterestPaid;
  @override
  MoneyCents get totalRepayment;

  /// Create a copy of LoanCalculation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoanCalculationImplCopyWith<_$LoanCalculationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
