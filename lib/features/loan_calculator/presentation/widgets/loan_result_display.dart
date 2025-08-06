import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/loan_calculation.dart';

/// Widget for displaying calculated loan results including monthly payment,
/// total interest paid, and total repayment amount.
class LoanResultDisplay extends StatelessWidget {
  /// The loan calculation results to display
  final LoanCalculation? loanCalculation;

  const LoanResultDisplay({
    super.key,
    this.loanCalculation,
  });

  /// Formats a dollar amount as currency with CAD suffix
  String _formatCurrency(int amountCents) {
    final formatter = NumberFormat.currency(
      locale: 'en_CA',
      symbol: '\$',
      decimalDigits: 2,
    );
    return '${formatter.format(amountCents / 100)} CAD';
  }

  @override
  Widget build(BuildContext context) {
    final showHelpText =
        loanCalculation == null || loanCalculation!.monthlyPaymentCents == 0;

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
            // Monthly Payment
            _ResultRow(
              label: 'Monthly Payment',
              value: _formatCurrency(loanCalculation?.monthlyPaymentCents ?? 0),
              icon: Icons.payment,
              valueStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Total Interest Paid
            _ResultRow(
              label: 'Total Interest Paid',
              value: _formatCurrency(loanCalculation?.totalInterestCents ?? 0),
              icon: Icons.trending_up,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 12),

            // Total Repayment
            _ResultRow(
              label: 'Total Repayment',
              value: _formatCurrency(loanCalculation?.totalRepaymentCents ?? 0),
              icon: Icons.account_balance_wallet,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),

            if (showHelpText)
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Enter valid loan details to see calculations',
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

/// Internal widget for displaying a result row with icon, label, and value
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
