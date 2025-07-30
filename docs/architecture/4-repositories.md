# 4\. Repositories

Repositories abstract data sources, providing a clean interface for the Domain Layer to interact with data. They handle data conversion between `Model` (Data Layer) and `Entity` (Domain Layer).

## 4.1. Loan Calculation Repository

  * **`lib/features/loan_calculator/domain/repositories/i_loan_calculation_repository.dart`**
    ```dart
    import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';

    abstract class ILoanCalculationRepository {
      Future<int> saveLoanCalculation(LoanCalculation calculation);
      Future<LoanCalculation?> getLoanCalculationById(int id);
      Future<List<LoanCalculation>> getAllLoanCalculations();
      Future<int> deleteLoanCalculation(int id);
      Future<LoanCalculation?> getLastLoanCalculation(); // For pre-filling UI
    }
    ```
  * **`lib/features/loan_calculator/data/repositories/loan_calculation_repository_impl.dart`**
    (Implements `ILoanCalculationRepository`, depends on `IDatabaseManager`, converts `LoanCalculation` entity to `LoanCalculationModel` for DB operations and vice-versa.)
    ```dart
    import 'package:personal_finance_calculator/core/services/i_database_manager.dart';
    import 'package:personal_finance_calculator/features/loan_calculator/data/models/loan_calculation_model.dart';
    import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';
    import 'package:personal_finance_calculator/features/loan_calculator/domain/repositories/i_loan_calculation_repository.dart';
    import 'package:sqflite/sqflite.dart';

    class LoanCalculationRepositoryImpl implements ILoanCalculationRepository {
      final IDatabaseManager _dbManager;
      final String _tableName = 'loan_calculations';

      LoanCalculationRepositoryImpl(this._dbManager);

      @override
      Future<int> saveLoanCalculation(LoanCalculation calculation) async {
        final db = await _dbManager.database;
        final model = LoanCalculationModel.fromEntity(calculation);

        if (model.id != null) {
          await db.update(_tableName, model.toMap(), where: 'id = ?', whereArgs: [model.id], conflictAlgorithm: ConflictAlgorithm.replace);
          return model.id!;
        } else {
          return await db.insert(_tableName, model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
        }
      }

      @override
      Future<LoanCalculation?> getLoanCalculationById(int id) async {
        final db = await _dbManager.database;
        final List<Map<String, dynamic>> maps = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
        return maps.isNotEmpty ? LoanCalculationModel.fromMap(maps.first).toEntity() : null;
      }

      @override
      Future<List<LoanCalculation>> getAllLoanCalculations() async {
        final db = await _dbManager.database;
        final List<Map<String, dynamic>> maps = await db.query(_tableName, orderBy: 'savedAt DESC');
        return List.generate(maps.length, (i) => LoanCalculationModel.fromMap(maps[i]).toEntity());
      }

      @override
      Future<int> deleteLoanCalculation(int id) async {
        final db = await _dbManager.database;
        return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
      }

      @override
      Future<LoanCalculation?> getLastLoanCalculation() async {
        final db = await _dbManager.database;
        final List<Map<String, dynamic>> maps = await db.query(_tableName, orderBy: 'savedAt DESC', limit: 1);
        return maps.isNotEmpty ? LoanCalculationModel.fromMap(maps.first).toEntity() : null;
      }
    }
    ```
  * **`lib/features/loan_calculator/providers/loan_calculation_providers.dart`**
    (Includes `loanCalculationRepositoryProvider` and other related Riverpod providers for the feature)

## 4.2. Investment Calculation Repository

  * **`lib/features/investment_calculator/domain/repositories/i_investment_calculation_repository.dart`**
    (Similar abstract interface for `InvestmentCalculation` operations)
  * **`lib/features/investment_calculator/data/repositories/investment_calculation_repository_impl.dart`**
    (Implements `IInvestmentCalculationRepository`, depends on `IDatabaseManager`, converts `InvestmentCalculation` to `InvestmentCalculationModel` and vice-versa.)
  * **`lib/features/investment_calculator/providers/investment_calculation_providers.dart`**
    (Includes `investmentCalculationRepositoryProvider` and other related Riverpod providers)

## 4.3. History Repository

  * **`lib/features/history/domain/repositories/i_history_repository.dart`**
    ```dart
    import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';
    import 'package:personal_finance_calculator/features/investment_calculator/domain/entities/investment_calculation.dart';

    abstract class IHistoryRepository {
      Future<List<LoanCalculation>> getLoanHistory({String? query});
      Future<List<InvestmentCalculation>> getInvestmentHistory({String? query});
      Future<List<dynamic>> getAllHistory({String? query}); // Returns combined list
      Future<void> deleteHistoryItem(String type, int id); // 'loan' or 'investment'
    }
    ```
  * **`lib/features/history/data/repositories/history_repository_impl.dart`**
    (Implements `IHistoryRepository`, depends on `ILoanCalculationRepository` and `IInvestmentCalculationRepository` to aggregate data from both sources.)
  * **`lib/features/history/providers/history_providers.dart`**
    (Includes `historyRepositoryProvider` and other related Riverpod providers)

## 4.4. Bank Rates Repository

  * **`lib/features/bank_rates/data/datasources/bank_rates_api_client.dart`**
    (Handles direct HTTP calls to the external API, parses raw JSON into `BankRateModel`s, handles network/server errors.)
    ```dart
    import 'dart:convert';
    import 'package:http/http.dart' as http;
    import 'package:personal_finance_calculator/features/bank_rates/data/models/bank_rate_model.dart';
    import 'package:personal_finance_calculator/core/errors/exceptions.dart'; // Custom exception types

    class BankRatesApiClient {
      final String _baseUrl = '[https://api.example.com/canadian-bank-rates](https://api.example.com/canadian-bank-rates)'; // Placeholder API URL

      Future<List<BankRateModel>> fetchBankRates() async {
        try {
          final response = await http.get(Uri.parse(_baseUrl));

          if (response.statusCode == 200) {
            final List<dynamic> jsonList = json.decode(response.body);
            return jsonList.map((json) => BankRateModel.fromJson(json)).toList();
          } else if (response.statusCode == 404) {
            throw NotFoundException('API endpoint not found: $_baseUrl');
          } else {
            throw ServerException('Failed to load bank rates. Status: ${response.statusCode}');
          }
        } on http.ClientException catch (e) {
          throw NetworkException('Network error: ${e.message}');
        } catch (e) {
          throw UnknownException('An unexpected error occurred: $e');
        }
      }
    }
    ```
  * **`lib/features/bank_rates/domain/repositories/i_bank_rates_repository.dart`**
    ```dart
    import 'package:personal_finance_calculator/features/bank_rates/domain/entities/bank_rate.dart';

    abstract class IBankRatesRepository {
      Future<List<BankRate>> getBankRates();
    }
    ```
  * **`lib/features/bank_rates/data/repositories/bank_rates_repository_impl.dart`**
    (Implements `IBankRatesRepository`, depends on `BankRatesApiClient`, converts `BankRateModel` to `BankRate` entity.)
  * **`lib/features/bank_rates/providers/bank_rates_providers.dart`**
    (Includes `bankRatesApiClientProvider`, `bankRatesRepositoryProvider`, and other related Riverpod providers)

-----
