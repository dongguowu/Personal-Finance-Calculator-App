import 'package:personal_finance_calculator/features/history/domain/entities/history_item.dart';
import 'package:personal_finance_calculator/features/history/domain/repositories/i_history_repository.dart';

class DeleteHistoryItemUseCase {
  final IHistoryRepository _repository;

  DeleteHistoryItemUseCase(this._repository);

  Future<void> call(int id, HistoryItemType type) {
    return _repository.deleteHistoryItem(id, type);
  }
}
