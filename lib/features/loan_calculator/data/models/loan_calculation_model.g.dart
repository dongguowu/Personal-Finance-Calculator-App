// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_calculation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoanCalculationModelImpl _$$LoanCalculationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LoanCalculationModelImpl(
      loanAmount: (json['loanAmount'] as num).toInt(),
      annualInterestRate: (json['annualInterestRate'] as num).toDouble(),
      loanTermInYears: (json['loanTermInYears'] as num).toInt(),
      monthlyPayment: (json['monthlyPayment'] as num).toInt(),
      totalInterestPaid: (json['totalInterestPaid'] as num).toInt(),
      totalRepayment: (json['totalRepayment'] as num).toInt(),
    );

Map<String, dynamic> _$$LoanCalculationModelImplToJson(
        _$LoanCalculationModelImpl instance) =>
    <String, dynamic>{
      'loanAmount': instance.loanAmount,
      'annualInterestRate': instance.annualInterestRate,
      'loanTermInYears': instance.loanTermInYears,
      'monthlyPayment': instance.monthlyPayment,
      'totalInterestPaid': instance.totalInterestPaid,
      'totalRepayment': instance.totalRepayment,
    };
