import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finance_calculator/features/bank_rates/presentation/widgets/bank_rate_list.dart';

@RoutePage()
class BankRatesPage extends ConsumerWidget {
  const BankRatesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Rates'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: const BankRateList(),
    );
  }
}
