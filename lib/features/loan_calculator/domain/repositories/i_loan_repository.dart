import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';

abstract class ILoanRepository {
  Future<void> saveLoanCalculation(LoanCalculation calculation);
  Future<LoanCalculation?> getLastLoanCalculation();
  Future<void> deleteLoanCalculation(LoanCalculation calculation);
}
