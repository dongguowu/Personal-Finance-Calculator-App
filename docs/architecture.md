---

### File 2: `architecture.md`

```markdown
# Personal Finance Calculator App: Technical Architecture Document

**Version:** 1.0
**Date:** July 30, 2025
---

## 1. Architectural Overview: Clean Architecture / Layered Approach

The application adheres to a **Clean Architecture / Layered Architecture** pattern. This design emphasizes separation of concerns, making the codebase modular, testable, and maintainable.

**Conceptual Layer Diagram:**

````

\+---------------------+
|   Presentation Layer  |  (Widgets, UI, ViewModels/Notifiers - e.g., using Riverpod notifiers)
\+----------^----------+
| Depends on
\+----------v----------+
|     Domain Layer    |  (Entities, Use Cases, Repository Interfaces) - Core business logic, independent of UI/DB.
\+----------^----------+
| Depends on
\+----------v----------+
|      Data Layer     |  (Models, Data Sources, Repository Implementations) - Handles data persistence and external APIs.
\+----------^----------+
| Depends on
\+----------v----------+
|  Platform/External  |  (sqflite, http, OS services) - Concrete implementations of external technologies.
\+---------------------+

**Presentation Layer & State Management:** The top layer contains the UI Widgets. To keep them simple, we use a **Riverpod Notifier** which acts as a ViewModel. This separates the UI from the application's state and logic. It orchestrates the data flow, isolates UI from business rules, and makes both much easier to test independently.

```

**Module Structure (`lib/` directory):**

The project will adopt a feature-first directory structure, promoting better organization and scalability.

```

lib/
├── core/                        (Cross-cutting concerns, shared utilities, global providers)
│   ├── constants/               (App-wide constants, enums, global configurations)
│   ├── errors/                  (Custom Exception classes for structured error handling)
│   ├── providers/               (Global Riverpod providers, e.g., Database Manager)
│   ├── services/                (Shared services like database management)
│   └── utils/                   (Helper functions, e.g., currency formatting)
├── features/                    (Encapsulates all code related to a specific feature)
│   ├── bank\_rates/              (Feature: Display bank interest rates)
│   │   ├── data/
│   │   │   ├── datasources/     (e.g., `bank_rates_api_client.dart` for network calls)
│   │   │   └── repositories/    (e.g., `bank_rates_repository_impl.dart` implements domain interface)
│   │   ├── domain/
│   │   │   ├── entities/        (e.g., `bank_rate.dart` - pure Dart objects)
│   │   │   ├── repositories/    (e.g., `i_bank_rates_repository.dart` - abstract interfaces)
│   │   │   └── usecases/        (e.g., `get_bank_rates_usecase.dart` - business logic)
│   │   ├── presentation/
│   │   │   ├── pages/           (e.g., `bank_rates_page.dart` - main screen for feature)
│   │   │   └── widgets/         (e.g., `bank_rate_list_item.dart` - reusable UI components)
│   │   └── providers/           (Riverpod providers specific to the bank rates feature)
│   ├── history/                 (Feature: Saved calculation history)
│   │   ├── data/
│   │   │   └── repositories/    (e.g., `history_repository_impl.dart`)
│   │   ├── domain/
│   │   │   ├── entities/        (e.g., `history_item.dart` - if a combined entity is used)
│   │   │   ├── repositories/    (e.g., `i_history_repository.dart`)
│   │   │   └── usecases/        (e.g., `get_history_usecase.dart`, `delete_history_item_usecase.dart`)
│   │   ├── presentation/
│   │   │   ├── pages/           (e.g., `history_page.dart`)
│   │   │   └── widgets/         (e.g., `history_list_item.dart`)
│   │   └── providers/           (Riverpod providers specific to history)
│   ├── loan\_calculator/         (Feature: Loan calculation functionality)
│   │   ├── data/
│   │   │   └── repositories/    (e.g., `loan_calculation_repository_impl.dart`)
│   │   ├── domain/
│   │   │   ├── entities/        (e.g., `loan_calculation.dart`)
│   │   │   ├── repositories/    (e.g., `i_loan_calculation_repository.dart`)
│   │   │   └── usecases/        (e.g., `calculate_loan_payment_usecase.dart`, `save_loan_calculation_usecase.dart`, etc.)
│   │   ├── presentation/
│   │   │   ├── pages/           (e.g., `loan_calculator_page.dart`)
│   │   │   └── widgets/         (e.g., `loan_input_form.dart`, `loan_result_display.dart`)
│   │   └── providers/           (Riverpod providers specific to loan calculator)
│   ├── investment\_calculator/   (Feature: Investment calculation functionality)
│   │   ├── data/
│   │   │   └── repositories/    (e.g., `investment_calculation_repository_impl.dart`)
│   │   ├── domain/
│   │   │   ├── entities/        (e.g., `investment_calculation.dart`)
│   │   │   ├── repositories/    (e.g., `i_investment_calculation_repository.dart`)
│   │   │   └── usecases/        (e.g., `calculate_investment_return_usecase.dart`, `save_investment_calculation_usecase.dart`, etc.)
│   │   ├── presentation/
│   │   │   ├── pages/           (e.g., `investment_calculator_page.dart`)
│   │   │   └── widgets/         (e.g., `investment_input_form.dart`, `investment_result_display.dart`)
│   │   └── providers/           (Riverpod providers specific to investment calculator)
├── routes/                      (AutoRoute configuration for app navigation)
├── main.dart                    (App entry point)

````

---

## 2. Shared Services: `IDatabaseManager`

A central service for `sqflite` operations is critical for managing database connections, centralizing schema management, and enhancing testability by providing an injectable interface.

### `lib/core/services/i_database_manager.dart`

```dart
import 'package:sqflite/sqflite.dart';

abstract class IDatabaseManager {
  Future<Database> get database;
  Future<void> close(); // For proper resource management
}
````

### `lib/core/services/sqflite_manager.dart` (Concrete Implementation)

```dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:personal_finance_calculator/core/services/i_database_manager.dart';

class SqfLiteManager implements IDatabaseManager {
  static final SqfLiteManager _instance = SqfLiteManager._internal();
  static Database? _database;

  factory SqfLiteManager() {
    return _instance;
  }

  SqfLiteManager._internal();

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'personal_finance_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE loan_calculations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        loanAmount INTEGER NOT NULL,          -- Stored in cents
        interestRate REAL NOT NULL,
        loanTermYears INTEGER NOT NULL,
        monthlyPayment INTEGER NOT NULL,      -- Stored in cents
        totalInterestPaid INTEGER NOT NULL,   -- Stored in cents
        totalRepayment INTEGER NOT NULL,      -- Stored in cents
        savedAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE investment_calculations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        initialInvestment INTEGER NOT NULL,   -- Stored in cents
        regularContribution INTEGER NOT NULL, -- Stored in cents
        contributionFrequency TEXT NOT NULL,
        interestRate REAL NOT NULL,
        investmentPeriodYears INTEGER NOT NULL,
        estimatedFutureValue INTEGER NOT NULL,-- Stored in cents
        totalContributions INTEGER NOT NULL,  -- Stored in cents
        totalEarnings INTEGER NOT NULL,       -- Stored in cents
        savedAt TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Implement schema migration logic here for future versions if DB schema changes.
    // Example: if (oldVersion < 2) { await db.execute("ALTER TABLE some_table ADD COLUMN new_column TEXT;"); }
  }

  @override
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
```

### `lib/core/providers/database_providers.dart` (Riverpod Setup)

Global Riverpod providers to make the database manager and instance available throughout the application using dependency injection.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:personal_finance_calculator/core/services/sqflite_manager.dart';
import 'package:personal_finance_calculator/core/services/i_database_manager.dart';

part 'database_providers.g.dart'; // Generated by riverpod_generator

@Riverpod(keepAlive: true) // Keeps the manager instance alive for the app's lifetime
IDatabaseManager databaseManager(DatabaseManagerRef ref) {
  return SqfLiteManager(); // Returns the singleton instance
}

@Riverpod(keepAlive: true) // Provides direct access to the `Database` object
Future<Database> databaseInstance(DatabaseInstanceRef ref) async {
  final manager = ref.read(databaseManagerProvider); // Depends on the manager provider
  return manager.database; // Awaits the database initialization
}
```

-----

## 3\. Data Models & Entities

**Crucial Decision:** All money-related values (`loanAmount`, `monthlyPayment`, `initialInvestment`, `regularContribution`, `estimatedFutureValue`, `totalInterestPaid`, `totalRepayment`, `totalContributions`, `totalEarnings`) will be stored and processed as **`int` (integers representing cents)**. This design choice mitigates floating-point inaccuracies commonly associated with `double` when handling financial calculations. The Presentation Layer (UI) will be responsible for converting user-friendly `double` inputs (e.g., "$100.50") into `int` (e.g., `10050`) for internal processing and storage, and for formatting `int` outputs back to `double` strings (e.g., "$100.50") for display.

### 3.1. Loan Calculation

  * **`lib/features/loan_calculator/domain/entities/loan_calculation.dart`**
    (Domain Entity - defines the core business object, independent of storage details)
    ```dart
    import 'package:freezed_annotation/freezed_annotation.dart';

    part 'loan_calculation.freezed.dart'; // Generated by freezed
    part 'loan_calculation.g.dart';     // Generated by json_serializable (if used for to/from json)

    @freezed
    class LoanCalculation with _$LoanCalculation {
      const factory LoanCalculation({
        int? id,                            // Null for unsaved calculations
        required int loanAmountCents,          // Stored as integer cents (e.g., $100.50 -> 10050)
        required double interestRate,          // Annual interest rate as percentage (e.g., 3.5 for 3.5%)
        required int loanTermYears,            // Loan term in full years
        required int monthlyPaymentCents,      // Calculated monthly payment in cents
        required int totalInterestPaidCents,   // Total interest paid over loan term in cents
        required int totalRepaymentCents,      // Total repayment (principal + interest) in cents
        required DateTime savedAt,             // Timestamp for when the calculation was saved
      }) = _LoanCalculation;

      factory LoanCalculation.fromJson(Map<String, dynamic> json) => _$LoanCalculationFromJson(json);
    }
    ```
  * **`lib/features/loan_calculator/data/models/loan_calculation_model.dart`**
    (Data Model - handles conversion between Entity and `sqflite` Map representation)
    ```dart
    import 'package:personal_finance_calculator/features/loan_calculator/domain/entities/loan_calculation.dart';

    class LoanCalculationModel {
      final int? id;
      final int loanAmountCents;
      final double interestRate;
      final int loanTermYears;
      final int monthlyPaymentCents;
      final int totalInterestPaidCents;
      final int totalRepaymentCents;
      final DateTime savedAt;

      LoanCalculationModel({
        this.id,
        required this.loanAmountCents,
        required this.interestRate,
        required this.loanTermYears,
        required this.monthlyPaymentCents,
        required this.totalInterestPaidCents,
        required this.totalRepaymentCents,
        required this.savedAt,
      });

      // Converts the model to a Map suitable for sqflite insertion/update
      Map<String, dynamic> toMap() {
        return {
          'id': id,
          'loanAmount': loanAmountCents,
          'interestRate': interestRate,
          'loanTermYears': loanTermYears,
          'monthlyPayment': monthlyPaymentCents,
          'totalInterestPaid': totalInterestPaidCents,
          'totalRepayment': totalRepaymentCents,
          'savedAt': savedAt.toIso8601String(), // Store DateTime as ISO 8601 String
        };
      }

      // Creates a model from a Map retrieved from sqflite
      factory LoanCalculationModel.fromMap(Map<String, dynamic> map) {
        return LoanCalculationModel(
          id: map['id'] as int?,
          loanAmountCents: map['loanAmount'] as int,
          interestRate: map['interestRate'] as double,
          loanTermYears: map['loanTermYears'] as int,
          monthlyPaymentCents: map['monthlyPayment'] as int,
          totalInterestPaidCents: map['totalInterestPaid'] as int,
          totalRepaymentCents: map['totalRepayment'] as int,
          savedAt: DateTime.parse(map['savedAt'] as String), // Parse back to DateTime
        );
      }

      // Converts a domain entity to a data model for persistence
      factory LoanCalculationModel.fromEntity(LoanCalculation entity) {
        return LoanCalculationModel(
          id: entity.id,
          loanAmountCents: entity.loanAmountCents,
          interestRate: entity.interestRate,
          loanTermYears: entity.loanTermYears,
          monthlyPaymentCents: entity.monthlyPaymentCents,
          totalInterestPaidCents: entity.totalInterestPaidCents,
          totalRepaymentCents: entity.totalRepaymentCents,
          savedAt: entity.savedAt,
        );
      }

      // Converts the data model back to a domain entity for use in the domain/presentation layers
      LoanCalculation toEntity() {
        return LoanCalculation(
          id: id,
          loanAmountCents: loanAmountCents,
          interestRate: interestRate,
          loanTermYears: loanTermYears,
          monthlyPaymentCents: monthlyPaymentCents,
          totalInterestPaidCents: totalInterestPaidCents,
          totalRepaymentCents: totalRepaymentCents,
          savedAt: savedAt,
        );
      }
    }
    ```

### 3.2. Investment Calculation

  * **`lib/features/investment_calculator/domain/entities/investment_calculation.dart`**
    ```dart
    import 'package:freezed_annotation/freezed_annotation.dart';

    part 'investment_calculation.freezed.dart';
    part 'investment_calculation.g.dart';

    @freezed
    class InvestmentCalculation with _$InvestmentCalculation {
      const factory InvestmentCalculation({
        int? id,
        required int initialInvestmentCents,    // Initial lump sum in cents
        required int regularContributionCents,  // Regular contribution amount in cents
        required String contributionFrequency,  // e.g., 'Monthly', 'Quarterly', 'Annually'
        required double interestRate,          // Annual interest rate as percentage
        required int investmentPeriodYears,    // Investment duration in full years
        required int estimatedFutureValueCents,// Projected future value in cents
        required int totalContributionsCents,  // Sum of initial + all regular contributions in cents
        required int totalEarningsCents,       // Estimated earnings (future value - total contributions) in cents
        required DateTime savedAt,             // Timestamp for when the calculation was saved
      }) = _InvestmentCalculation;

      factory InvestmentCalculation.fromJson(Map<String, dynamic> json) => _$InvestmentCalculationFromJson(json);
    }
    ```
  * **`lib/features/investment_calculator/data/models/investment_calculation_model.dart`**
    (Similar structure to `LoanCalculationModel` for `toMap()`, `fromMap()`, `fromEntity()`, `toEntity()`, handling `int` cents and `DateTime` string conversions.)

### 3.3. Bank Rate

  * **`lib/features/bank_rates/domain/entities/bank_rate.dart`**
    ```dart
    import 'package:freezed_annotation/freezed_annotation.dart';

    part 'bank_rate.freezed.dart';
    part 'bank_rate.g.dart';

    @freezed
    class BankRate with _$BankRate {
      const factory BankRate({
        required String bankName,
        required String productName,
        required double interestRate, // Percentage, typically remains double
        required String rateType,     // e.g., 'Mortgage', 'GIC', 'Savings'
        required int termMonths,      // e.g., 60 for 5-Year Mortgage, 12 for 1-Year GIC
        required DateTime lastUpdated, // Timestamp for when this rate was last updated/published by bank
        String? additionalInfo,       // Optional extra details
      }) = _BankRate;

      factory BankRate.fromJson(Map<String, dynamic> json) => _$BankRateFromJson(json);
    }
    ```
  * **`lib/features/bank_rates/data/models/bank_rate_model.dart`**
    (Data Model - for mapping directly from API JSON responses)
    ```dart
    import 'package:json_annotation/json_annotation.dart';
    import 'package:personal_finance_calculator/features/bank_rates/domain/entities/bank_rate.dart';

    part 'bank_rate_model.g.dart'; // Generated by json_serializable

    @JsonSerializable()
    class BankRateModel {
      final String bankName;
      final String productName;
      final double interestRate;
      final String rateType;
      final int termMonths;
      final String lastUpdated; // As string from API, parsed to DateTime in toEntity()
      final String? additionalInfo;

      BankRateModel({
        required this.bankName,
        required this.productName,
        required this.interestRate,
        required this.rateType,
        required this.termMonths,
        required this.lastUpdated,
        this.additionalInfo,
      });

      factory BankRateModel.fromJson(Map<String, dynamic> json) => _$BankRateModelFromJson(json);
      Map<String, dynamic> toJson() => _$BankRateModelToJson(this);

      // Converts the data model to a domain entity
      BankRate toEntity() {
        return BankRate(
          bankName: bankName,
          productName: productName,
          interestRate: interestRate,
          rateType: rateType,
          termMonths: termMonths,
          lastUpdated: DateTime.parse(lastUpdated), // Parse ISO 8601 string to DateTime
          additionalInfo: additionalInfo,
        );
      }
    }
    ```

-----

## 4\. Repositories

Repositories abstract data sources, providing a clean interface for the Domain Layer to interact with data. They handle data conversion between `Model` (Data Layer) and `Entity` (Domain Layer).

### 4.1. Loan Calculation Repository

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

### 4.2. Investment Calculation Repository

  * **`lib/features/investment_calculator/domain/repositories/i_investment_calculation_repository.dart`**
    (Similar abstract interface for `InvestmentCalculation` operations)
  * **`lib/features/investment_calculator/data/repositories/investment_calculation_repository_impl.dart`**
    (Implements `IInvestmentCalculationRepository`, depends on `IDatabaseManager`, converts `InvestmentCalculation` to `InvestmentCalculationModel` and vice-versa.)
  * **`lib/features/investment_calculator/providers/investment_calculation_providers.dart`**
    (Includes `investmentCalculationRepositoryProvider` and other related Riverpod providers)

### 4.3. History Repository

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

### 4.4. Bank Rates Repository

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

## 5\. Use Cases

Use Cases (also known as Interactors) encapsulate the specific business rules and operations of the application. They reside in the Domain Layer, depend on Repository Interfaces, and orchestrate data flow between the Presentation Layer and the Repositories.

### 5.1. Loan Calculator Use Cases

  * **`lib/features/loan_calculator/domain/usecases/calculate_loan_payment_usecase.dart`**
    (Performs the mathematical calculation based on provided inputs.)
    ```dart
    import 'dart:math';
    import '../entities/loan_calculation.dart';

    class CalculateLoanPaymentUseCase {
      LoanCalculation execute({
        required int loanAmountCents,
        required double annualInterestRate,
        required int loanTermYears,
      }) {
        // ... implementation details ...
      }
    }
    ```
  * **`lib/features/loan_calculator/domain/usecases/save_loan_calculation_usecase.dart`**
    (Persists a `LoanCalculation` entity via `ILoanCalculationRepository`.)
  * **`lib/features/loan_calculator/domain/usecases/get_loan_calculation_usecase.dart`**
    (Retrieves a specific `LoanCalculation` by ID.)
  * **`lib/features/loan_calculator/domain/usecases/get_last_loan_calculation_usecase.dart`**
    (Retrieves the most recently saved `LoanCalculation` for pre-filling.)

### 5.2. Investment Calculator Use Cases

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
        if (initialInvestmentCents < 0 || initialInvestmentCents >= 9900000000 ||
            regularContributionCents < 0 || regularContributionCents >= 9900000000 ||
            annualInterestRate < 0 || annualInterestRate >= 100 ||
            investmentPeriodYears <= 0 || investmentPeriodYears > 50) {
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

### 5.3. History Use Cases

  * **`lib/features/history/domain/usecases/get_history_usecase.dart`**
    (Aggregates and retrieves all saved calculations.)
  * **`lib/features/history/domain/usecases/delete_history_item_usecase.dart`**
    (Deletes a specific history item.)

### 5.4. Bank Rates Use Cases

  * **`lib/features/bank_rates/domain/usecases/get_bank_rates_usecase.dart`**
    (Fetches bank rates from the `IBankRatesRepository`.)

-----

## 6\. QA Strategy

The QA strategy is designed to ensure the quality, reliability, and correctness of the Personal Finance Calculator App, verifying all user story acceptance criteria are met.

### 6.1. Overall Goal

Ensure the Personal Finance Calculator App functions correctly, is reliable, performs well, and meets all defined user requirements for the MVP release.

### 6.2. Core Testing Pillars

1.  **Functional Testing:** Verify each feature (Loan, Investment, Bank Rates, History) performs as per user stories.
2.  **Data Integrity Testing:** Ensure financial calculations are accurate (especially with `int` cents) and data is correctly persisted/retrieved.
3.  **UI/UX Testing:** Confirm intuitive, responsive, visually consistent (Material 3) UI with smooth user experience.
4.  **Performance Testing (Basic):** Ensure app responsiveness and calculation speed.
5.  **Cross-Platform Compatibility Testing (Basic):** Verify core functionality on representative Android/iOS devices/simulators.

### 6.3. Types of Testing

A multi-layered testing approach will be implemented:

1.  **Unit Tests:**

      * **Purpose:** Test individual functions, classes, and methods in isolation. Primarily for the Domain Layer (Use Cases, Entities) and Data Layer (Models, Repositories with mocked dependencies, API Clients).
      * **Scope Examples:**
          * **Calculation Logic:** `CalculateLoanPaymentUseCase`, `CalculateInvestmentReturnUseCase` with various inputs and edge cases.
          * **Model Conversions:** `toMap()`, `fromMap()`, `toEntity()`, `fromEntity()` for all `*Model` classes.
          * **Repository Logic:** Verify `_dbManager` or `_apiClient` calls and data transformations, using mocking.
      * **Tools:** Dart's built-in `test` package, `mockito`.

2.  **Widget Tests (Component/UI Tests):**

      * **Purpose:** Test individual Flutter widgets in isolation, ensuring correct rendering, input handling, and data display.
      * **Scope Examples:**
          * Input fields validation and decimal handling (conversion to/from `int` cents).
          * Output fields formatting (currency, percentages).
          * Button states (e.g., "Save" button toggling).
          * List item rendering for History and Bank Rates.
          * Error message displays and loading indicators.
      * **Tools:** Flutter's `flutter_test` package.

3.  **Integration Tests:**

      * **Purpose:** Test the interaction between different layers (e.g., UI with Use Cases and Repositories, or a repository with the actual `sqflite` database). These run on a device or emulator.
      * **Scope Examples:**
          * **Full Feature Flows:** End-to-end scenarios like "Calculate Loan -\> Save -\> Navigate to History -\> Recall -\> Delete".
          * **Database Interaction:** Verify data persistence and retrieval using the actual `sqflite` database.
          * **API Integration:** Test `BankRatesApiClient` fetching and parsing data (may require mock API or controlled environment).
          * **Navigation:** Test `AutoRoute` navigation between all relevant screens.
      * **Tools:** Flutter's `integration_test` package.

4.  **End-to-End (E2E) / UI Automation Tests (Future Consideration for MVP):**

      * **Purpose:** Simulate real user scenarios across the entire application on a real device/emulator. Comprehensive integration tests might cover this for MVP.
      * **Tools:** Appium or extended `integration_test` for future consideration.

### 6.4. Test Planning & Execution

  * **Test Cases:** Develop detailed test cases for each user story's acceptance criteria.
  * **Test Environment:** Utilize emulators/simulators for automated tests. Perform critical manual testing on representative physical devices.
  * **Continuous Integration (CI):** Integrate automated tests into a CI pipeline (e.g., GitHub Actions) to run on every code commit, ensuring early detection of regressions.

<!-- end list -->
