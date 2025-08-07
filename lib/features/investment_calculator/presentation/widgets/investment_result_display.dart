import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finance_calculator/features/investment_calculator/domain/entities/investment_calculation.dart';
import 'package:personal_finance_calculator/core/share/money_cents.dart';
import 'package:personal_finance_calculator/features/investment_calculator/presentation/providers/investment_calculator_provider.dart';

class InvestmentResultDisplay extends ConsumerWidget {
  const InvestmentResultDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final InvestmentCalculation? investmentCalculation = ref.watch(investmentCalculatorProvider);

    final showHelpText =
        investmentCalculation == null || investmentCalculation.futureValue == MoneyCents.zero;

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculation Results',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _ResultRow(
              label: 'Future Value',
              value: investmentCalculation?.futureValue.toFormattedCurrency() ?? MoneyCents.zero.toFormattedCurrency(),
              icon: Icons.show_chart,
              valueStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _ResultRow(
              label: 'Total Contributions',
              value: investmentCalculation?.totalContributions.toFormattedCurrency() ?? MoneyCents.zero.toFormattedCurrency(),
              icon: Icons.add_circle_outline,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const SizedBox(height: 12),
            _ResultRow(
              label: 'Total Earnings',
              value: investmentCalculation?.totalEarnings.toFormattedCurrency() ?? MoneyCents.zero.toFormattedCurrency(),
              icon: Icons.trending_up,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
            ),
            if (showHelpText)
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Enter valid investment details to see calculations',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final TextStyle? valueStyle;

  const _ResultRow({
    required this.label,
    required this.value,
    required this.icon,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: valueStyle ?? Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
