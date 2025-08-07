import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finance_calculator/features/bank_rates/presentation/providers/bank_rates_provider.dart';

class BankRateList extends ConsumerWidget {
  const BankRateList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bankRates = ref.watch(bankRatesProvider);

    return bankRates.when(
      data: (rates) {
        return RefreshIndicator(
          onRefresh: () => ref.refresh(bankRatesProvider.future),
          child: ListView.builder(
            itemCount: rates.length,
            itemBuilder: (context, index) {
              final rate = rates[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('${rate.bankName} - ${rate.productName}'),
                  subtitle: Text('Term: ${rate.term}'),
                  trailing: Text(
                    '${rate.interestRate.toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Failed to load bank rates.'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => ref.refresh(bankRatesProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
