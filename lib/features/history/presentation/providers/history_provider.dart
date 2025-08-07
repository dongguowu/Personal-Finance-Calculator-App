import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finance_calculator/features/history/data/repositories/history_repository.dart';
import 'package:personal_finance_calculator/features/history/domain/entities/history_item.dart';
import 'package:personal_finance_calculator/features/history/domain/usecases/delete_history_item_usecase.dart';
import 'package:personal_finance_calculator/features/history/domain/usecases/get_history_usecase.dart';

final historyRepositoryProvider = Provider((ref) => HistoryRepository());

final getHistoryUseCaseProvider = Provider((ref) => GetHistoryUseCase(ref.watch(historyRepositoryProvider)));

final deleteHistoryItemUseCaseProvider = Provider((ref) => DeleteHistoryItemUseCase(ref.watch(historyRepositoryProvider)));

final historyProvider = FutureProvider<List<HistoryItem>>((ref) {
  final getHistoryUseCase = ref.watch(getHistoryUseCaseProvider);
  return getHistoryUseCase.call();
});
