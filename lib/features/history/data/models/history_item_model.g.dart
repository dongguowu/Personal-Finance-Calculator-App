// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryItemModelImpl _$$HistoryItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HistoryItemModelImpl(
      id: (json['id'] as num).toInt(),
      type: $enumDecode(_$HistoryItemTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      loanCalculation: json['loanCalculation'] == null
          ? null
          : LoanCalculationModel.fromJson(
              json['loanCalculation'] as Map<String, dynamic>),
      investmentCalculation: json['investmentCalculation'] == null
          ? null
          : InvestmentCalculationModel.fromJson(
              json['investmentCalculation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HistoryItemModelImplToJson(
        _$HistoryItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$HistoryItemTypeEnumMap[instance.type]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'loanCalculation': instance.loanCalculation,
      'investmentCalculation': instance.investmentCalculation,
    };

const _$HistoryItemTypeEnumMap = {
  HistoryItemType.loan: 'loan',
  HistoryItemType.investment: 'investment',
};
