import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finance_calculator/features/history/presentation/providers/history_provider.dart';

class HistoryList extends ConsumerWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);

    return history.when(
      data: (items) {
        if (items.isEmpty) {
          return const Center(child: Text('No history yet.'));
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(item.type == HistoryItemType.loan
                    ? 'Loan Calculation'
                    : 'Investment Calculation'),
                subtitle: Text(
                  item.type == HistoryItemType.loan
                      ? 'Amount: ${item.loanCalculation!.loanAmount.toFormattedCurrency()}'
                      : 'Initial: ${item.investmentCalculation!.initialInvestment.toFormattedCurrency()}',
                ),
                trailing: Text(
                  '${item.createdAt.day}/${item.createdAt.month}/${item.createdAt.year}',
                ),
                onTap: () {
                  // TODO: Implement navigation to calculator
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Center(child: Text('Failed to load history.')),
    );
  }
}
