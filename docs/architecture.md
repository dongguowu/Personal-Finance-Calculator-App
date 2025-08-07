# Personal Finance Calculator App: Technical Architecture Document

**Version:** 1.2
**Date:** August 07, 2025

---

## 1. Architectural Overview: Clean Architecture / Layered Approach

The application adheres to a **Clean Architecture / Layered Architecture** pattern. This design emphasizes separation of concerns, making the codebase modular, testable, and maintainable.

**Conceptual Layer Diagram:**

```
+---------------------+
|   Presentation Layer  |  (Widgets, UI, ViewModels/Notifiers - e.g., using Riverpod notifiers)
+----------^----------+
           | Depends on
+----------v----------+
|     Domain Layer    |  (Entities, Use Cases, Repository Interfaces) - Core business logic, independent of UI/DB.
+----------^----------+
           | Depends on
+----------v----------+
|      Data Layer     |  (Models, Data Sources, Repository Implementations) - Handles data persistence and external APIs.
+----------^----------+
           | Depends on
+----------v----------+
|  Platform/External  |  (sqflite, http, OS services) - Concrete implementations of external technologies.
+---------------------+
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
│   ├── share/                   (Shared code, e.g., money_cents.dart)
│   └── utils/                   (Helper functions, e.g., currency formatting)
├── features/                    (Encapsulates all code related to a specific feature)
│   ├── bank_rates/              (Feature: Display bank interest rates)
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
│   │   └── ... (structure follows other features)
│   ├── loan_calculator/         (Feature: Loan calculation functionality)
│   │   └── ... (structure follows other features)
│   ├── investment_calculator/   (Feature: Investment calculation functionality)
│   │   └── ... (structure follows other features)
├── routes/                      (AutoRoute configuration for app navigation)
├── main.dart                    (App entry point)
```

## 2. Presentation Layer & State Management

The top layer contains the UI Widgets. To keep them simple, we use a **Riverpod Notifier** which acts as a ViewModel. This separates the UI from the application's state and logic. It orchestrates the data flow, isolates UI from business rules, and makes both much easier to test independently.

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
```

### `lib/core/services/sqflite_manager.dart` (Concrete Implementation)

```dart
// ... (Implementation remains the same)
```

### `lib/core/providers/database_providers.dart` (Riverpod Setup)

```dart
// ... (Implementation remains the same)
```

---

## 4. Data Models & Entities

**Crucial Decision:** To ensure financial accuracy and avoid floating-point errors, all monetary values will be handled as integers representing cents. A dedicated `MoneyCents` class will be implemented for this purpose, encapsulating all related logic and preventing precision issues throughout the application. This is a core, cross-cutting entity.

---

## 5. Repositories

Repositories abstract data sources, providing a clean interface for the Domain Layer to interact with data.

### 5.1. Bank Rates Repository

The `BankRatesApiClient` will fetch data from the official Bank of Canada Valet API.

```dart
class BankRatesApiClient {
  final String _baseUrl = 'https://www.bankofcanada.ca/valet/'; // Official API URL

  Future<List<BankRateModel>> fetchBankRates() async {
    // ... (Implementation using http package)
  }
}

abstract class IBankRatesRepository {
  Future<List<BankRate>> getBankRates();
}
```

---

## 6. Use Cases

Use Cases (or Interactors) encapsulate specific business rules. They are orchestrated by the Presentation Layer's ViewModels to execute application-specific logic.

---

## 7. Technical Specifications & Conventions

### 7.1 Technology Versions
*   **Flutter:** v3.24.0 or higher
*   **Dart:** v3.8.0 or higher
*   **Linting:** `very_good_analysis`

### 7.2 Frontend Conventions
*   **Responsive Design:** Use `LayoutBuilder` and `MediaQuery`.
*   **Styling:** Central `ThemeData` in `lib/core/theme/app_theme.dart`.
*   **File Naming:** `snake_case_with_lowercase.dart`.

---

## 8. QA Strategy

The QA strategy is designed to ensure the quality and reliability of the app. It aligns with the high-level strategy in the Project Brief and is composed of multiple layers:

1.  **Unit Tests:**
    *   **Purpose:** Test individual functions and classes in isolation (Use Cases, `MoneyCents`, etc.).
    *   **Tools:** `test`, `mockito`.

2.  **Widget Tests:**
    *   **Purpose:** Test individual Flutter widgets to ensure they render and behave correctly.
    *   **Tools:** `flutter_test`.

3.  **Integration Tests:**
    *   **Purpose:** Test the interaction between different layers, such as UI flows and database interactions.
    *   **Tools:** `integration_test`.

This multi-layered approach ensures that the application is reliable, maintainable, and performs as expected.
