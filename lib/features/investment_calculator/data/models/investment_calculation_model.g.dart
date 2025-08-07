// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment_calculation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvestmentCalculationModelImpl _$$InvestmentCalculationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InvestmentCalculationModelImpl(
      initialInvestment: (json['initialInvestment'] as num).toInt(),
      regularContribution: (json['regularContribution'] as num).toInt(),
      contributionFrequency: $enumDecode(
          _$ContributionFrequencyEnumMap, json['contributionFrequency']),
      annualInterestRate: (json['annualInterestRate'] as num).toDouble(),
      investmentPeriodInYears: (json['investmentPeriodInYears'] as num).toInt(),
      futureValue: (json['futureValue'] as num).toInt(),
      totalContributions: (json['totalContributions'] as num).toInt(),
      totalEarnings: (json['totalEarnings'] as num).toInt(),
    );

Map<String, dynamic> _$$InvestmentCalculationModelImplToJson(
        _$InvestmentCalculationModelImpl instance) =>
    <String, dynamic>{
      'initialInvestment': instance.initialInvestment,
      'regularContribution': instance.regularContribution,
      'contributionFrequency':
          _$ContributionFrequencyEnumMap[instance.contributionFrequency]!,
      'annualInterestRate': instance.annualInterestRate,
      'investmentPeriodInYears': instance.investmentPeriodInYears,
      'futureValue': instance.futureValue,
      'totalContributions': instance.totalContributions,
      'totalEarnings': instance.totalEarnings,
    };

const _$ContributionFrequencyEnumMap = {
  ContributionFrequency.monthly: 'monthly',
  ContributionFrequency.quarterly: 'quarterly',
  ContributionFrequency.annually: 'annually',
};
