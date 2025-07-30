import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget for capturing loan input parameters from the user.
/// Provides input fields for loan amount, annual interest rate, and loan term.
class LoanInputForm extends StatefulWidget {
  /// Callback function triggered when any input value changes
  final Function({
    double? loanAmount,
    double? annualInterestRate,
    int? loanTermYears,
  }) onInputChanged;

  const LoanInputForm({
    super.key,
    required this.onInputChanged,
  });

  @override
  State<LoanInputForm> createState() => _LoanInputFormState();
}

class _LoanInputFormState extends State<LoanInputForm> {
  final _formKey = GlobalKey<FormState>();

  double? _loanAmount;
  double? _annualInterestRate;
  int? _loanTermYears;

  void _notifyInputChanged() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onInputChanged(
        loanAmount: _loanAmount,
        annualInterestRate: _annualInterestRate,
        loanTermYears: _loanTermYears,
      );
    } else {
      widget.onInputChanged(
        loanAmount: 0,
        annualInterestRate: 0,
        loanTermYears: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          onChanged: _notifyInputChanged,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loan Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              
              // Loan Amount Field
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Loan Amount',
                  prefixText: '\$ ',
                  suffixText: 'CAD',
                  border: OutlineInputBorder(),
                  helperText: 'Enter the total loan amount',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a loan amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Loan amount must be greater than 0';
                  }
                  return null;
                },
                onSaved: (value) => _loanAmount = double.tryParse(value!),
              ),
              const SizedBox(height: 16),
              
              // Annual Interest Rate Field
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Annual Interest Rate',
                  suffixText: '%',
                  border: OutlineInputBorder(),
                  helperText: 'Enter the annual interest rate (e.g., 5.25)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an interest rate';
                  }
                  final rate = double.tryParse(value);
                  if (rate == null || rate < 0) {
                    return 'Interest rate must be 0 or greater';
                  }
                  return null;
                },
                onSaved: (value) => _annualInterestRate = double.tryParse(value!),
              ),
              const SizedBox(height: 16),
              
              // Loan Term Field
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Loan Term',
                  suffixText: 'Years',
                  border: OutlineInputBorder(),
                  helperText: 'Enter the loan term in years',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a loan term';
                  }
                  final term = int.tryParse(value);
                  if (term == null || term <= 0) {
                    return 'Loan term must be greater than 0';
                  }
                  return null;
                },
                onSaved: (value) => _loanTermYears = int.tryParse(value!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
