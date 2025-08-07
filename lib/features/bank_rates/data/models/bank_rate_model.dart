import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_finance_calculator/features/bank_rates/domain/entities/bank_rate.dart';

part 'bank_rate_model.freezed.dart';
part 'bank_rate_model.g.dart';

@freezed
class BankRateModel with _$BankRateModel {
  const BankRateModel._();

  const factory BankRateModel({
    required String bankName,
    required String productName,
    required double interestRate,
    required String term,
  }) = _BankRateModel;

  factory BankRateModel.fromDomain(BankRate domain) {
    return BankRateModel(
      bankName: domain.bankName,
      productName: domain.productName,
      interestRate: domain.interestRate,
      term: domain.term,
    );
  }

  BankRate toDomain() {
    return BankRate(
      bankName: bankName,
      productName: productName,
      interestRate: interestRate,
      term: term,
    );
  }

  factory BankRateModel.fromJson(Map<String, dynamic> json) =>
      _$BankRateModelFromJson(json);
}
