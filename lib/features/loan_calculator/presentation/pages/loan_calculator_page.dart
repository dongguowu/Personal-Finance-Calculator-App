import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finance_calculator/features/loan_calculator/presentation/providers/loan_calculator_provider.dart';
import 'package:personal_finance_calculator/features/loan_calculator/presentation/widgets/loan_input_form.dart';
import 'package:personal_finance_calculator/features/loan_calculator/presentation/widgets/loan_result_display.dart';

@RoutePage()
class LoanCalculatorPage extends ConsumerWidget {
  const LoanCalculatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Calculator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoanInputForm(
              onInputChanged: ({
                double? loanAmount,
                double? annualInterestRate,
                int? loanTermYears,
              }) {
                ref.read(loanCalculatorProvider.notifier).calculate(
                      loanAmount: loanAmount ?? 0,
                      annualInterestRate: annualInterestRate ?? 0,
                      loanTermInYears: loanTermYears ?? 0,
                    );
              },
            ),
            const LoanResultDisplay(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
