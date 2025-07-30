import 'package:flutter/material.dart';
import 'features/loan_calculator/presentation/pages/loan_calculator_page.dart';

void main() {
  runApp(const PersonalFinanceCalculatorApp());
}

class PersonalFinanceCalculatorApp extends StatelessWidget {
  const PersonalFinanceCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoanCalculatorPage(),
    );
  }
}