import 'package:personal_finance_calculator/features/bank_rates/domain/entities/bank_rate.dart';

abstract class IBankRateRepository {
  Future<List<BankRate>> getBankRates();
}
