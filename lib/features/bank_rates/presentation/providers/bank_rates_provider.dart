import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finance_calculator/features/bank_rates/data/repositories/bank_rate_repository.dart';
import 'package:personal_finance_calculator/features/bank_rates/domain/entities/bank_rate.dart';
import 'package:personal_finance_calculator/features/bank_rates/domain/usecases/fetch_bank_rates_usecase.dart';

final bankRateRepositoryProvider = Provider((ref) => BankRateRepository());

final fetchBankRatesUseCaseProvider = Provider((ref) => FetchBankRatesUseCase(ref.watch(bankRateRepositoryProvider)));

final bankRatesProvider = FutureProvider<List<BankRate>>((ref) {
  final fetchBankRatesUseCase = ref.watch(fetchBankRatesUseCaseProvider);
  return fetchBankRatesUseCase.call();
});
