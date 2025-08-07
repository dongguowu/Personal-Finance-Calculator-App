import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finance_calculator/core/navigation/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: PersonalFinanceCalculatorApp(),
    ),
  );
}

class PersonalFinanceCalculatorApp extends StatelessWidget {
  const PersonalFinanceCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      title: 'Personal Finance Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter.config(),
    );
  }
}