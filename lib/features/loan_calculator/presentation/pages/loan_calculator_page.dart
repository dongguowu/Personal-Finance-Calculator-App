import 'package:flutter/material.dart';
import '../widgets/loan_input_form.dart';
import '../widgets/loan_result_display.dart';
import '../../domain/entities/loan_calculation.dart';
import '../../domain/usecases/calculate_loan_payment_usecase.dart';

/// Main page for the loan calculator feature.
/// Integrates the input form and result display widgets and handles
/// the loan calculation logic.
class LoanCalculatorPage extends StatefulWidget {
  const LoanCalculatorPage({super.key});

  @override
  State<LoanCalculatorPage> createState() => _LoanCalculatorPageState();
}

class _LoanCalculatorPageState extends State<LoanCalculatorPage> {
  final _calculateLoanPaymentUseCase = CalculateLoanPaymentUseCase();
  
  LoanCalculation _currentCalculation = const LoanCalculation(
    loanAmountCents: 0,
    annualInterestRate: 0,
    loanTermYears: 0,
    monthlyPaymentCents: 0,
    totalInterestCents: 0,
    totalRepaymentCents: 0,
  );

  /// Handles input changes from the loan input form and recalculates results
  void _onInputChanged({
    double? loanAmount,
    double? annualInterestRate,
    int? loanTermYears,
  }) {
    setState(() {
      _currentCalculation = _calculateLoanPaymentUseCase.execute(
        loanAmountDollars: loanAmount ?? 0,
        annualInterestRate: annualInterestRate ?? 0,
        loanTermYears: loanTermYears ?? 0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Calculator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Loan Input Form
            LoanInputForm(
              onInputChanged: _onInputChanged,
            ),
            
            // Loan Result Display
            LoanResultDisplay(
              loanCalculation: _currentCalculation,
            ),
            
            // Additional spacing at bottom for better UX
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
