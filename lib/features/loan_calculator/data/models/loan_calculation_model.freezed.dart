// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loan_calculation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoanCalculationModel _$LoanCalculationModelFromJson(Map<String, dynamic> json) {
  return _LoanCalculationModel.fromJson(json);
}

/// @nodoc
mixin _$LoanCalculationModel {
  int get loanAmount => throw _privateConstructorUsedError;
  double get annualInterestRate => throw _privateConstructorUsedError;
  int get loanTermInYears => throw _privateConstructorUsedError;
  int get monthlyPayment => throw _privateConstructorUsedError;
  int get totalInterestPaid => throw _privateConstructorUsedError;
  int get totalRepayment => throw _privateConstructorUsedError;

  /// Serializes this LoanCalculationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoanCalculationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoanCalculationModelCopyWith<LoanCalculationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoanCalculationModelCopyWith<$Res> {
  factory $LoanCalculationModelCopyWith(LoanCalculationModel value,
          $Res Function(LoanCalculationModel) then) =
      _$LoanCalculationModelCopyWithImpl<$Res, LoanCalculationModel>;
  @useResult
  $Res call(
      {int loanAmount,
      double annualInterestRate,
      int loanTermInYears,
      int monthlyPayment,
      int totalInterestPaid,
      int totalRepayment});
}

/// @nodoc
class _$LoanCalculationModelCopyWithImpl<$Res,
        $Val extends LoanCalculationModel>
    implements $LoanCalculationModelCopyWith<$Res> {
  _$LoanCalculationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoanCalculationModel
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
              as int,
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
              as int,
      totalInterestPaid: null == totalInterestPaid
          ? _value.totalInterestPaid
          : totalInterestPaid // ignore: cast_nullable_to_non_nullable
              as int,
      totalRepayment: null == totalRepayment
          ? _value.totalRepayment
          : totalRepayment // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoanCalculationModelImplCopyWith<$Res>
    implements $LoanCalculationModelCopyWith<$Res> {
  factory _$$LoanCalculationModelImplCopyWith(_$LoanCalculationModelImpl value,
          $Res Function(_$LoanCalculationModelImpl) then) =
      __$$LoanCalculationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int loanAmount,
      double annualInterestRate,
      int loanTermInYears,
      int monthlyPayment,
      int totalInterestPaid,
      int totalRepayment});
}

/// @nodoc
class __$$LoanCalculationModelImplCopyWithImpl<$Res>
    extends _$LoanCalculationModelCopyWithImpl<$Res, _$LoanCalculationModelImpl>
    implements _$$LoanCalculationModelImplCopyWith<$Res> {
  __$$LoanCalculationModelImplCopyWithImpl(_$LoanCalculationModelImpl _value,
      $Res Function(_$LoanCalculationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoanCalculationModel
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
    return _then(_$LoanCalculationModelImpl(
      loanAmount: null == loanAmount
          ? _value.loanAmount
          : loanAmount // ignore: cast_nullable_to_non_nullable
              as int,
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
              as int,
      totalInterestPaid: null == totalInterestPaid
          ? _value.totalInterestPaid
          : totalInterestPaid // ignore: cast_nullable_to_non_nullable
              as int,
      totalRepayment: null == totalRepayment
          ? _value.totalRepayment
          : totalRepayment // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoanCalculationModelImpl extends _LoanCalculationModel {
  const _$LoanCalculationModelImpl(
      {required this.loanAmount,
      required this.annualInterestRate,
      required this.loanTermInYears,
      required this.monthlyPayment,
      required this.totalInterestPaid,
      required this.totalRepayment})
      : super._();

  factory _$LoanCalculationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoanCalculationModelImplFromJson(json);

  @override
  final int loanAmount;
  @override
  final double annualInterestRate;
  @override
  final int loanTermInYears;
  @override
  final int monthlyPayment;
  @override
  final int totalInterestPaid;
  @override
  final int totalRepayment;

  @override
  String toString() {
    return 'LoanCalculationModel(loanAmount: $loanAmount, annualInterestRate: $annualInterestRate, loanTermInYears: $loanTermInYears, monthlyPayment: $monthlyPayment, totalInterestPaid: $totalInterestPaid, totalRepayment: $totalRepayment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoanCalculationModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, loanAmount, annualInterestRate,
      loanTermInYears, monthlyPayment, totalInterestPaid, totalRepayment);

  /// Create a copy of LoanCalculationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoanCalculationModelImplCopyWith<_$LoanCalculationModelImpl>
      get copyWith =>
          __$$LoanCalculationModelImplCopyWithImpl<_$LoanCalculationModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoanCalculationModelImplToJson(
      this,
    );
  }
}

abstract class _LoanCalculationModel extends LoanCalculationModel {
  const factory _LoanCalculationModel(
      {required final int loanAmount,
      required final double annualInterestRate,
      required final int loanTermInYears,
      required final int monthlyPayment,
      required final int totalInterestPaid,
      required final int totalRepayment}) = _$LoanCalculationModelImpl;
  const _LoanCalculationModel._() : super._();

  factory _LoanCalculationModel.fromJson(Map<String, dynamic> json) =
      _$LoanCalculationModelImpl.fromJson;

  @override
  int get loanAmount;
  @override
  double get annualInterestRate;
  @override
  int get loanTermInYears;
  @override
  int get monthlyPayment;
  @override
  int get totalInterestPaid;
  @override
  int get totalRepayment;

  /// Create a copy of LoanCalculationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoanCalculationModelImplCopyWith<_$LoanCalculationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
