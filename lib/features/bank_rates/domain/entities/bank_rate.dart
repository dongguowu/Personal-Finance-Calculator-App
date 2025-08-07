import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_rate.freezed.dart';

@freezed
class BankRate with _$BankRate {
  const factory BankRate({
    required String bankName,
    required String productName,
    required double interestRate,
    required String term,
  }) = _BankRate;
}
