# 5\. Use Cases

Use Cases (also known as Interactors) encapsulate the specific business rules and operations of the application. They reside in the Domain Layer, depend on Repository Interfaces, and orchestrate data flow between the Presentation Layer and the Repositories.

## 5.1. Loan Calculator Use Cases

  * **`lib/features/loan_calculator/domain/usecases/calculate_loan_payment_usecase.dart`**
    (Performs the mathematical calculation based on provided inputs.)
    ```dart
    import 'dart:math';

    class CalculateLoanPaymentUseCase {
      // All money-related inputs/outputs are assumed to be in cents, except interestRate (percentage)
      // Returns monthly payment in double (cents), which will be rounded for display.
      double call({
        required int loanAmountCents,
        required double annualInterestRate, // e.g., 3.0 for 3%
        required int loanTermYears,
      }) {
        if (loanAmountCents <= 0 || loanTermYears <= 0) return 0.0;
        if (annualInterestRate < 0) return 0.0; // Invalid, or could throw specific exception

        final double monthlyInterestRate = (annualInterestRate / 100.0) / 12.0;
        final int numberOfPayments = loanTermYears * 12;

        if (monthlyInterestRate == 0) {
          return (loanAmountCents / numberOfPayments).roundToDouble();
        } else {
          return loanAmountCents *
              (monthlyInterestRate * pow(1 + monthlyInterestRate, numberOfPayments)) /
              (pow(1 + monthlyInterestRate, numberOfPayments) - 1);
        }
      }
    }
    ```
  * **`lib/features/loan_calculator/domain/usecases/save_loan_calculation_usecase.dart`**
    (Persists a `LoanCalculation` entity via `ILoanCalculationRepository`.)
  * **`lib/features/loan_calculator/domain/usecases/get_loan_calculation_usecase.dart`**
    (Retrieves a specific `LoanCalculation` by ID.)
  * **`lib/features/loan_calculator/domain/usecases/get_last_loan_calculation_usecase.dart`**
    (Retrieves the most recently saved `LoanCalculation` for pre-filling.)

## 5.2. Investment Calculator Use Cases

  * **`lib/features/investment_calculator/domain/usecases/calculate_investment_return_usecase.dart`**
    (Performs the mathematical calculation for investment growth.)
    ```dart
    import 'dart:math';
    import 'package:personal_finance_calculator/features/investment_calculator/domain/entities/investment_calculation.dart';

    class CalculateInvestmentReturnUseCase {
      InvestmentCalculation call({
        required int initialInvestmentCents,
        required int regularContributionCents,
        required String contributionFrequency,
        required double annualInterestRate,
        required int investmentPeriodYears,
      }) {
        if (initialInvestmentCents < 0 || regularContributionCents < 0 || annualInterestRate < 0 || investmentPeriodYears <= 0) {
          throw ArgumentError('Invalid input for investment calculation');
        }

        double ratePerPeriod;
        int totalPeriods;
        int frequencyPerYear;

        switch (contributionFrequency) {
          case 'Monthly': frequencyPerYear = 12; break;
          case 'Quarterly': frequencyPerYear = 4; break;
          case 'Annually': frequencyPerYear = 1; break;
          default: throw ArgumentError('Invalid contribution frequency');
        }

        ratePerPeriod = (annualInterestRate / 100.0) / frequencyPerYear;
        totalPeriods = investmentPeriodYears * frequencyPerYear;

        double futureValue = 0.0;
        int totalContributions = 0;

        // Calculate future value of initial investment
        if (ratePerPeriod == 0) {
          futureValue = initialInvestmentCents.toDouble();
        } else {
          futureValue = initialInvestmentCents * pow(1 + ratePerPeriod, totalPeriods);
        }

        // Calculate future value of regular contributions
        if (regularContributionCents > 0) {
          if (ratePerPeriod == 0) {
            futureValue += (regularContributionCents * totalPeriods).toDouble();
          } else {
            futureValue += regularContributionCents *
                ((pow(1 + ratePerPeriod, totalPeriods) - 1) / ratePerPeriod);
          }
          totalContributions = initialInvestmentCents + (regularContributionCents * totalPeriods);
        } else {
          totalContributions = initialInvestmentCents;
        }

        final int estimatedFutureValueCents = futureValue.round();
        final int totalEarningsCents = estimatedFutureValueCents - totalContributions;

        return InvestmentCalculation(
          initialInvestmentCents: initialInvestmentCents,
          regularContributionCents: regularContributionCents,
          contributionFrequency: contributionFrequency,
          interestRate: annualInterestRate,
          investmentPeriodYears: investmentPeriodYears,
          estimatedFutureValueCents: estimatedFutureValueCents,
          totalContributionsCents: totalContributions,
          totalEarningsCents: totalEarningsCents,
          savedAt: DateTime.now(), // Use current time for newly calculated result
        );
      }
    }
    ```
  * **`lib/features/investment_calculator/domain/usecases/save_investment_calculation_usecase.dart`**
    (Persists an `InvestmentCalculation` entity.)
  * **`lib/features/investment_calculator/domain/usecases/get_investment_calculation_usecase.dart`**
    (Retrieves a specific `InvestmentCalculation` by ID.)
  * **`lib/features/investment_calculator/domain/usecases/get_last_investment_calculation_usecase.dart`**
    (Retrieves the most recently saved `InvestmentCalculation`.)

## 5.3. History Use Cases

  * **`lib/features/history/domain/usecases/get_history_usecase.dart`**
    (Aggregates and retrieves all saved calculations.)
  * **`lib/features/history/domain/usecases/delete_history_item_usecase.dart`**
    (Deletes a specific history item.)

## 5.4. Bank Rates Use Cases

  * **`lib/features/bank_rates/domain/usecases/get_bank_rates_usecase.dart`**
    (Fetches bank rates from the `IBankRatesRepository`.)

-----
