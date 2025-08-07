---

### File 2: `architecture.md`

```markdown
# Personal Finance Calculator App: Technical Architecture Document

**Version:** 1.1
**Date:** August 6, 2025
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
## 2. Presentation Layer & State Management

**Presentation Layer & State Management:** The top layer contains the UI Widgets. To keep them simple, we use a **Riverpod Notifier** which acts as a ViewModel. This separates the UI from the application's state and logic. It orchestrates the data flow, isolates UI from business rules, and makes both much easier to test independently.

This pattern is a core principle of the architecture for several reasons:
-   **State Encapsulation**: The `Notifier` holds the complete state for its feature (inputs and results).
-   **Logic Isolation**: It orchestrates calls to the domain layer's `UseCases`, keeping business logic separate from the UI.
-   **Improved Testability**: `Notifiers` can be tested independently of the UI, and widgets can be tested with mock providers.
-   **Reactivity**: UI widgets simply listen to the provider and react to state changes, without containing complex logic themselves.

---

## 3. Shared Services: `IDatabaseManager`

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

## 4\. Data Models & Entities

**Crucial Decision:** All money-related values will be stored and processed as 'MoneyCents' to avoid floating-point precision issues.

### 4.1. Loan Calculation


### 4.2. Investment Calculation


### 4.3. Bank Rate


-----

## 5\. Repositories

Repositories abstract data sources, providing a clean interface for the Domain Layer to interact with data. They handle data conversion between `Model` (Data Layer) and `Entity` (Domain Layer).

### 5.1. History Repository

    ```dart
    abstract class IHistoryRepository {
      Future<List<LoanCalculation>> getLoanHistory({String? query});
      Future<List<InvestmentCalculation>> getInvestmentHistory({String? query});
      Future<List<dynamic>> getAllHistory({String? query}); // Returns combined list
      Future<void> deleteHistoryItem(String type, int id); // 'loan' or 'investment'
    }
    ```

### 5.2. Bank Rates Repository

    ```dart
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
    ```dart
    abstract class IBankRatesRepository {
      Future<List<BankRate>> getBankRates();
    }
    ```
-----

## 6\. Use Cases

Use Cases (also known as Interactors) encapsulate the specific business rules and operations of the application. They reside in the Domain Layer, depend on Repository Interfaces, and orchestrate data flow between the Presentation Layer and the Repositories.

### 6.1. Loan Calculator Use Cases

### 6.2. Investment Calculator Use Cases

### 6.3. History Use Cases

### 6.4. Bank Rates Use Cases

-----

## 7. Technical Specifications & Conventions

### 7.1 Technology Versions

### 7.2 Frontend Conventions

*   **Responsive Design:** A responsive UI will be achieved using `LayoutBuilder` and `MediaQuery` to adapt to different screen sizes.
*   **Styling:** A central theme will be defined in `lib/core/theme/app_theme.dart` using `ThemeData` to ensure UI consistency.
*   **File Naming:** All Dart files will use `snake_case_with_lowercase.dart`.

### 7.3 Build and Environment Strategy

*   **Debug & Release:** The app will use standard `debug` and `release` build modes. Future environments (e.g., staging) will be managed with build flavors.

---

## 8. Operational & Security Readiness (Future Work)

The following areas are identified as critical for a full production release and will be addressed post-MVP.

### 8.1 Resilience

*   **Retry Policy:** A retry mechanism (e.g., using a package like `retry`) will be implemented for fetching bank rates.
*   **Caching:** A caching layer will be added for API responses to improve performance and handle offline scenarios.

### 8.2 Observability

*   **Logging & Crash Reporting:** A service like **Firebase Crashlytics** or **Sentry** will be integrated for production monitoring.

### 8.3 Security

*   **Local Data Encryption:** The `sqflite` database will be encrypted using a package like `sqflite_sqlcipher`.
*   **API Key Management:** API keys will be injected securely at build time using `--dart-define` to avoid committing them to source control.

---

## 9\. QA Strategy

The QA strategy is designed to ensure the quality, reliability, and correctness of the Personal Finance Calculator App, verifying all user story acceptance criteria are met.

### 9.1. Overall Goal

Ensure the Personal Finance Calculator App functions correctly, is reliable, performs well, and meets all defined user requirements for the MVP release.

### 9.2. Core Testing Pillars

1.  **Functional Testing:** Verify each feature (Loan, Investment, Bank Rates, History) performs as per user stories.
2.  **Data Integrity Testing:** Ensure financial calculations are accurate (especially with `int` cents) and data is correctly persisted/retrieved.
3.  **UI/UX Testing:** Confirm intuitive, responsive, visually consistent (Material 3) UI with smooth user experience.
4.  **Performance Testing (Basic):** Ensure app responsiveness and calculation speed.
5.  **Cross-Platform Compatibility Testing (Basic):** Verify core functionality on representative Android/iOS devices/simulators.

### 9.3. Types of Testing

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

### 9.4. Test Planning & Execution

  * **Test Cases:** Develop detailed test cases for each user story's acceptance criteria.
  * **Test Environment:** Utilize emulators/simulators for automated tests. Perform critical manual testing on representative physical devices.
  * **Continuous Integration (CI):** Integrate automated tests into a CI pipeline (e.g., GitHub Actions) to run on every code commit, ensuring early detection of regressions.

<!-- end list -->
