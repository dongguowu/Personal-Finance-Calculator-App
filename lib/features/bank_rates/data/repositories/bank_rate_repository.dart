import 'package:personal_finance_calculator/features/bank_rates/data/models/bank_rate_model.dart';
import 'package:personal_finance_calculator/features/bank_rates/domain/entities/bank_rate.dart';
import 'package.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BankRateRepository implements IBankRateRepository {
  final String _baseUrl = 'https://www.bankofcanada.ca/valet';

  @override
  Future<List<BankRate>> getBankRates() async {
    // This is a placeholder for the actual API call.
    // The PRD mentions this will depend on the API's offerings.
    // For now, I will return a mocked list.
    await Future.delayed(const Duration(seconds: 1));
    return [
      const BankRate(bankName: 'Bank A', productName: '5-year GIC', interestRate: 5.25, term: '5 years'),
      const BankRate(bankName: 'Bank B', productName: '3-year Mortgage', interestRate: 4.89, term: '3 years'),
      const BankRate(bankName: 'Bank C', productName: '1-year GIC', interestRate: 4.50, term: '1 year'),
    ];
  }
}
