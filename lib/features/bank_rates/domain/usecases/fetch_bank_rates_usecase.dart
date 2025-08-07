import 'package:personal_finance_calculator/features/bank_rates/domain/entities/bank_rate.dart';
import 'package:personal_finance_calculator/features/bank_rates/domain/repositories/i_bank_rate_repository.dart';

class FetchBankRatesUseCase {
  final IBankRateRepository _repository;

  FetchBankRatesUseCase(this._repository);

  Future<List<BankRate>> call() {
    return _repository.getBankRates();
  }
}
