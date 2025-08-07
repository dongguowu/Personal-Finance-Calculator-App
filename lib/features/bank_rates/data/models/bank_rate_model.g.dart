// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankRateModelImpl _$$BankRateModelImplFromJson(Map<String, dynamic> json) =>
    _$BankRateModelImpl(
      bankName: json['bankName'] as String,
      productName: json['productName'] as String,
      interestRate: (json['interestRate'] as num).toDouble(),
      term: json['term'] as String,
    );

Map<String, dynamic> _$$BankRateModelImplToJson(_$BankRateModelImpl instance) =>
    <String, dynamic>{
      'bankName': instance.bankName,
      'productName': instance.productName,
      'interestRate': instance.interestRate,
      'term': instance.term,
    };
