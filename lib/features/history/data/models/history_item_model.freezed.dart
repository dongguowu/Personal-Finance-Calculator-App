// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HistoryItemModel _$HistoryItemModelFromJson(Map<String, dynamic> json) {
  return _HistoryItemModel.fromJson(json);
}

/// @nodoc
mixin _$HistoryItemModel {
  int get id => throw _privateConstructorUsedError;
  HistoryItemType get type => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  LoanCalculationModel? get loanCalculation =>
      throw _privateConstructorUsedError;
  InvestmentCalculationModel? get investmentCalculation =>
      throw _privateConstructorUsedError;

  /// Serializes this HistoryItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HistoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryItemModelCopyWith<HistoryItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryItemModelCopyWith<$Res> {
  factory $HistoryItemModelCopyWith(
          HistoryItemModel value, $Res Function(HistoryItemModel) then) =
      _$HistoryItemModelCopyWithImpl<$Res, HistoryItemModel>;
  @useResult
  $Res call(
      {int id,
      HistoryItemType type,
      DateTime createdAt,
      LoanCalculationModel? loanCalculation,
      InvestmentCalculationModel? investmentCalculation});

  $LoanCalculationModelCopyWith<$Res>? get loanCalculation;
  $InvestmentCalculationModelCopyWith<$Res>? get investmentCalculation;
}

/// @nodoc
class _$HistoryItemModelCopyWithImpl<$Res, $Val extends HistoryItemModel>
    implements $HistoryItemModelCopyWith<$Res> {
  _$HistoryItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryItemModel
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
              as LoanCalculationModel?,
      investmentCalculation: freezed == investmentCalculation
          ? _value.investmentCalculation
          : investmentCalculation // ignore: cast_nullable_to_non_nullable
              as InvestmentCalculationModel?,
    ) as $Val);
  }

  /// Create a copy of HistoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoanCalculationModelCopyWith<$Res>? get loanCalculation {
    if (_value.loanCalculation == null) {
      return null;
    }

    return $LoanCalculationModelCopyWith<$Res>(_value.loanCalculation!,
        (value) {
      return _then(_value.copyWith(loanCalculation: value) as $Val);
    });
  }

  /// Create a copy of HistoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InvestmentCalculationModelCopyWith<$Res>? get investmentCalculation {
    if (_value.investmentCalculation == null) {
      return null;
    }

    return $InvestmentCalculationModelCopyWith<$Res>(
        _value.investmentCalculation!, (value) {
      return _then(_value.copyWith(investmentCalculation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HistoryItemModelImplCopyWith<$Res>
    implements $HistoryItemModelCopyWith<$Res> {
  factory _$$HistoryItemModelImplCopyWith(_$HistoryItemModelImpl value,
          $Res Function(_$HistoryItemModelImpl) then) =
      __$$HistoryItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      HistoryItemType type,
      DateTime createdAt,
      LoanCalculationModel? loanCalculation,
      InvestmentCalculationModel? investmentCalculation});

  @override
  $LoanCalculationModelCopyWith<$Res>? get loanCalculation;
  @override
  $InvestmentCalculationModelCopyWith<$Res>? get investmentCalculation;
}

/// @nodoc
class __$$HistoryItemModelImplCopyWithImpl<$Res>
    extends _$HistoryItemModelCopyWithImpl<$Res, _$HistoryItemModelImpl>
    implements _$$HistoryItemModelImplCopyWith<$Res> {
  __$$HistoryItemModelImplCopyWithImpl(_$HistoryItemModelImpl _value,
      $Res Function(_$HistoryItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryItemModel
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
    return _then(_$HistoryItemModelImpl(
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
              as LoanCalculationModel?,
      investmentCalculation: freezed == investmentCalculation
          ? _value.investmentCalculation
          : investmentCalculation // ignore: cast_nullable_to_non_nullable
              as InvestmentCalculationModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryItemModelImpl extends _HistoryItemModel {
  const _$HistoryItemModelImpl(
      {required this.id,
      required this.type,
      required this.createdAt,
      this.loanCalculation,
      this.investmentCalculation})
      : super._();

  factory _$HistoryItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryItemModelImplFromJson(json);

  @override
  final int id;
  @override
  final HistoryItemType type;
  @override
  final DateTime createdAt;
  @override
  final LoanCalculationModel? loanCalculation;
  @override
  final InvestmentCalculationModel? investmentCalculation;

  @override
  String toString() {
    return 'HistoryItemModel(id: $id, type: $type, createdAt: $createdAt, loanCalculation: $loanCalculation, investmentCalculation: $investmentCalculation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.loanCalculation, loanCalculation) ||
                other.loanCalculation == loanCalculation) &&
            (identical(other.investmentCalculation, investmentCalculation) ||
                other.investmentCalculation == investmentCalculation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, createdAt, loanCalculation, investmentCalculation);

  /// Create a copy of HistoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryItemModelImplCopyWith<_$HistoryItemModelImpl> get copyWith =>
      __$$HistoryItemModelImplCopyWithImpl<_$HistoryItemModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryItemModelImplToJson(
      this,
    );
  }
}

abstract class _HistoryItemModel extends HistoryItemModel {
  const factory _HistoryItemModel(
          {required final int id,
          required final HistoryItemType type,
          required final DateTime createdAt,
          final LoanCalculationModel? loanCalculation,
          final InvestmentCalculationModel? investmentCalculation}) =
      _$HistoryItemModelImpl;
  const _HistoryItemModel._() : super._();

  factory _HistoryItemModel.fromJson(Map<String, dynamic> json) =
      _$HistoryItemModelImpl.fromJson;

  @override
  int get id;
  @override
  HistoryItemType get type;
  @override
  DateTime get createdAt;
  @override
  LoanCalculationModel? get loanCalculation;
  @override
  InvestmentCalculationModel? get investmentCalculation;

  /// Create a copy of HistoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryItemModelImplCopyWith<_$HistoryItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
