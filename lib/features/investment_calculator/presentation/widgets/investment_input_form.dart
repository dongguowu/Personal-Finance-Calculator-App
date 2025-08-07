import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvestmentInputForm extends ConsumerStatefulWidget {
  final Function({
    double? initialInvestment,
    double? regularContribution,
    String? contributionFrequency,
    double? annualInterestRate,
    int? investmentPeriodInYears,
  }) onInputChanged;

  const InvestmentInputForm({
    super.key,
    required this.onInputChanged,
  });

  @override
  ConsumerState<InvestmentInputForm> createState() => _InvestmentInputFormState();
}

class _InvestmentInputFormState extends ConsumerState<InvestmentInputForm> {
  final _formKey = GlobalKey<FormState>();

  double? _initialInvestment;
  double? _regularContribution;
  String? _contributionFrequency = 'monthly';
  double? _annualInterestRate;
  int? _investmentPeriodInYears;

  void _notifyInputChanged() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onInputChanged(
        initialInvestment: _initialInvestment,
        regularContribution: _regularContribution,
        contributionFrequency: _contributionFrequency,
        annualInterestRate: _annualInterestRate,
        investmentPeriodInYears: _investmentPeriodInYears,
      );
    } else {
      widget.onInputChanged(
        initialInvestment: 0,
        regularContribution: 0,
        contributionFrequency: 'monthly',
        annualInterestRate: 0,
        investmentPeriodInYears: 0,
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
                'Investment Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Initial Investment',
                  prefixText: '\$ ',
                  suffixText: 'CAD',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount < 0) {
                    return 'Amount must be 0 or greater';
                  }
                  return null;
                },
                onSaved: (value) => _initialInvestment = double.tryParse(value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Regular Contribution',
                  prefixText: '\$ ',
                  suffixText: 'CAD',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount < 0) {
                    return 'Amount must be 0 or greater';
                  }
                  return null;
                },
                onSaved: (value) =>
                    _regularContribution = double.tryParse(value!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _contributionFrequency,
                decoration: const InputDecoration(
                  labelText: 'Contribution Frequency',
                  border: OutlineInputBorder(),
                ),
                items: ['monthly', 'quarterly', 'annually']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _contributionFrequency = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Annual Interest Rate',
                  suffixText: '%',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rate';
                  }
                  final rate = double.tryParse(value);
                  if (rate == null || rate < 0) {
                    return 'Rate must be 0 or greater';
                  }
                  return null;
                },
                onSaved: (value) =>
                    _annualInterestRate = double.tryParse(value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Investment Period',
                  suffixText: 'Years',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a period';
                  }
                  final term = int.tryParse(value);
                  if (term == null || term <= 0) {
                    return 'Period must be greater than 0';
                  }
                  return null;
                },
                onSaved: (value) =>
                    _investmentPeriodInYears = int.tryParse(value!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
