import 'package:personal_finance_calculator/features/investment_calculator/domain/entities/investment_calculation.dart';

abstract class IInvestmentRepository {
  Future<void> saveInvestmentCalculation(InvestmentCalculation calculation);
  Future<InvestmentCalculation?> getLastInvestmentCalculation();
  Future<void> deleteInvestmentCalculation(InvestmentCalculation calculation);
}
