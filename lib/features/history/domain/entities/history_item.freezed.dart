// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HistoryItem {
  int get id => throw _privateConstructorUsedError;
  HistoryItemType get type => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  LoanCalculation? get loanCalculation => throw _privateConstructorUsedError;
  InvestmentCalculation? get investmentCalculation =>
      throw _privateConstructorUsedError;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryItemCopyWith<HistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryItemCopyWith<$Res> {
  factory $HistoryItemCopyWith(
          HistoryItem value, $Res Function(HistoryItem) then) =
      _$HistoryItemCopyWithImpl<$Res, HistoryItem>;
  @useResult
  $Res call(
      {int id,
      HistoryItemType type,
      DateTime createdAt,
      LoanCalculation? loanCalculation,
      InvestmentCalculation? investmentCalculation});

  $LoanCalculationCopyWith<$Res>? get loanCalculation;
  $InvestmentCalculationCopyWith<$Res>? get investmentCalculation;
}

/// @nodoc
class _$HistoryItemCopyWithImpl<$Res, $Val extends HistoryItem>
    implements $HistoryItemCopyWith<$Res> {
  _$HistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? createdAt = null,
    Object? loanCalculation = freezed,
    Object? investmentCalculation = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HistoryItemType,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      loanCalculation: freezed == loanCalculation
          ? _value.loanCalculation
          : loanCalculation // ignore: cast_nullable_to_non_nullable
              as LoanCalculation?,
      investmentCalculation: freezed == investmentCalculation
          ? _value.investmentCalculation
          : investmentCalculation // ignore: cast_nullable_to_non_nullable
              as InvestmentCalculation?,
    ) as $Val);
  }

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoanCalculationCopyWith<$Res>? get loanCalculation {
    if (_value.loanCalculation == null) {
      return null;
    }

    return $LoanCalculationCopyWith<$Res>(_value.loanCalculation!, (value) {
      return _then(_value.copyWith(loanCalculation: value) as $Val);
    });
  }

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InvestmentCalculationCopyWith<$Res>? get investmentCalculation {
    if (_value.investmentCalculation == null) {
      return null;
    }

    return $InvestmentCalculationCopyWith<$Res>(_value.investmentCalculation!,
        (value) {
      return _then(_value.copyWith(investmentCalculation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HistoryItemImplCopyWith<$Res>
    implements $HistoryItemCopyWith<$Res> {
  factory _$$HistoryItemImplCopyWith(
          _$HistoryItemImpl value, $Res Function(_$HistoryItemImpl) then) =
      __$$HistoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      HistoryItemType type,
      DateTime createdAt,
      LoanCalculation? loanCalculation,
      InvestmentCalculation? investmentCalculation});

  @override
  $LoanCalculationCopyWith<$Res>? get loanCalculation;
  @override
  $InvestmentCalculationCopyWith<$Res>? get investmentCalculation;
}

/// @nodoc
class __$$HistoryItemImplCopyWithImpl<$Res>
    extends _$HistoryItemCopyWithImpl<$Res, _$HistoryItemImpl>
    implements _$$HistoryItemImplCopyWith<$Res> {
  __$$HistoryItemImplCopyWithImpl(
      _$HistoryItemImpl _value, $Res Function(_$HistoryItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? createdAt = null,
    Object? loanCalculation = freezed,
    Object? investmentCalculation = freezed,
  }) {
    return _then(_$HistoryItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HistoryItemType,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      loanCalculation: freezed == loanCalculation
          ? _value.loanCalculation
          : loanCalculation // ignore: cast_nullable_to_non_nullable
              as LoanCalculation?,
      investmentCalculation: freezed == investmentCalculation
          ? _value.investmentCalculation
          : investmentCalculation // ignore: cast_nullable_to_non_nullable
              as InvestmentCalculation?,
    ));
  }
}

/// @nodoc

class _$HistoryItemImpl implements _HistoryItem {
  const _$HistoryItemImpl(
      {required this.id,
      required this.type,
      required this.createdAt,
      this.loanCalculation,
      this.investmentCalculation});

  @override
  final int id;
  @override
  final HistoryItemType type;
  @override
  final DateTime createdAt;
  @override
  final LoanCalculation? loanCalculation;
  @override
  final InvestmentCalculation? investmentCalculation;

  @override
  String toString() {
    return 'HistoryItem(id: $id, type: $type, createdAt: $createdAt, loanCalculation: $loanCalculation, investmentCalculation: $investmentCalculation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.loanCalculation, loanCalculation) ||
                other.loanCalculation == loanCalculation) &&
            (identical(other.investmentCalculation, investmentCalculation) ||
                other.investmentCalculation == investmentCalculation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, createdAt, loanCalculation, investmentCalculation);

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryItemImplCopyWith<_$HistoryItemImpl> get copyWith =>
      __$$HistoryItemImplCopyWithImpl<_$HistoryItemImpl>(this, _$identity);
}

abstract class _HistoryItem implements HistoryItem {
  const factory _HistoryItem(
      {required final int id,
      required final HistoryItemType type,
      required final DateTime createdAt,
      final LoanCalculation? loanCalculation,
      final InvestmentCalculation? investmentCalculation}) = _$HistoryItemImpl;

  @override
  int get id;
  @override
  HistoryItemType get type;
  @override
  DateTime get createdAt;
  @override
  LoanCalculation? get loanCalculation;
  @override
  InvestmentCalculation? get investmentCalculation;

  /// Create a copy of HistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryItemImplCopyWith<_$HistoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
