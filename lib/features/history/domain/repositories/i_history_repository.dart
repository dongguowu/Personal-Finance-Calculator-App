import 'package:personal_finance_calculator/features/history/domain/entities/history_item.dart';

abstract class IHistoryRepository {
  Future<List<HistoryItem>> getHistory();
  Future<void> deleteHistoryItem(int id, HistoryItemType type);
}
