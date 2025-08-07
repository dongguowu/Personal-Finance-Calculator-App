// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_rate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BankRate {
  String get bankName => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  double get interestRate => throw _privateConstructorUsedError;
  String get term => throw _privateConstructorUsedError;

  /// Create a copy of BankRate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BankRateCopyWith<BankRate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankRateCopyWith<$Res> {
  factory $BankRateCopyWith(BankRate value, $Res Function(BankRate) then) =
      _$BankRateCopyWithImpl<$Res, BankRate>;
  @useResult
  $Res call(
      {String bankName, String productName, double interestRate, String term});
}

/// @nodoc
class _$BankRateCopyWithImpl<$Res, $Val extends BankRate>
    implements $BankRateCopyWith<$Res> {
  _$BankRateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BankRate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankName = null,
    Object? productName = null,
    Object? interestRate = null,
    Object? term = null,
  }) {
    return _then(_value.copyWith(
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      interestRate: null == interestRate
          ? _value.interestRate
          : interestRate // ignore: cast_nullable_to_non_nullable
              as double,
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BankRateImplCopyWith<$Res>
    implements $BankRateCopyWith<$Res> {
  factory _$$BankRateImplCopyWith(
          _$BankRateImpl value, $Res Function(_$BankRateImpl) then) =
      __$$BankRateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String bankName, String productName, double interestRate, String term});
}

/// @nodoc
class __$$BankRateImplCopyWithImpl<$Res>
    extends _$BankRateCopyWithImpl<$Res, _$BankRateImpl>
    implements _$$BankRateImplCopyWith<$Res> {
  __$$BankRateImplCopyWithImpl(
      _$BankRateImpl _value, $Res Function(_$BankRateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BankRate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankName = null,
    Object? productName = null,
    Object? interestRate = null,
    Object? term = null,
  }) {
    return _then(_$BankRateImpl(
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      interestRate: null == interestRate
          ? _value.interestRate
          : interestRate // ignore: cast_nullable_to_non_nullable
              as double,
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BankRateImpl implements _BankRate {
  const _$BankRateImpl(
      {required this.bankName,
      required this.productName,
      required this.interestRate,
      required this.term});

  @override
  final String bankName;
  @override
  final String productName;
  @override
  final double interestRate;
  @override
  final String term;

  @override
  String toString() {
    return 'BankRate(bankName: $bankName, productName: $productName, interestRate: $interestRate, term: $term)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankRateImpl &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.interestRate, interestRate) ||
                other.interestRate == interestRate) &&
            (identical(other.term, term) || other.term == term));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, bankName, productName, interestRate, term);

  /// Create a copy of BankRate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BankRateImplCopyWith<_$BankRateImpl> get copyWith =>
      __$$BankRateImplCopyWithImpl<_$BankRateImpl>(this, _$identity);
}

abstract class _BankRate implements BankRate {
  const factory _BankRate(
      {required final String bankName,
      required final String productName,
      required final double interestRate,
      required final String term}) = _$BankRateImpl;

  @override
  String get bankName;
  @override
  String get productName;
  @override
  double get interestRate;
  @override
  String get term;

  /// Create a copy of BankRate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BankRateImplCopyWith<_$BankRateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
