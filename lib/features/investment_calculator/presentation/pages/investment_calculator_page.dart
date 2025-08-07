import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finance_calculator/features/investment_calculator/presentation/providers/investment_calculator_provider.dart';
import 'package:personal_finance_calculator/features/investment_calculator/presentation/widgets/investment_input_form.dart';
import 'package:personal_finance_calculator/features/investment_calculator/presentation/widgets/investment_result_display.dart';

@RoutePage()
class InvestmentCalculatorPage extends ConsumerWidget {
  const InvestmentCalculatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investment Calculator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InvestmentInputForm(
              onInputChanged: ({
                double? initialInvestment,
                double? regularContribution,
                String? contributionFrequency,
                double? annualInterestRate,
                int? investmentPeriodInYears,
              }) {
                ref.read(investmentCalculatorProvider.notifier).calculate(
                      initialInvestment: initialInvestment ?? 0,
                      regularContribution: regularContribution ?? 0,
                      contributionFrequency: contributionFrequency ?? 'monthly',
                      annualInterestRate: annualInterestRate ?? 0,
                      investmentPeriodInYears: investmentPeriodInYears ?? 0,
                    );
              },
            ),
            const InvestmentResultDisplay(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
