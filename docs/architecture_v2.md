# Personal Finance Calculator App: Technical Architecture Document

**Version:** 1.1
**Date:** July 31, 2025
---

## 1. Architectural Overview: Clean Architecture / Layered Approach

The application adheres to a **Clean Architecture / Layered Architecture** pattern. This design emphasizes separation of concerns, making the codebase modular, testable, and maintainable.

**Conceptual Layer Diagram:**

````
+---------------------+
|   Presentation Layer  |  (Widgets, UI, ViewModels/Notifiers)
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
````

**Module Structure (`lib/` directory):**

The project will adopt a feature-first directory structure, promoting better organization and scalability.

```
lib/
├── core/                        (Cross-cutting concerns, shared utilities, global providers)
│   ├── constants/               (App-wide constants, enums, global configurations)
│   ├── errors/                  (Custom Exception classes for structured error handling)
│   ├── providers/               (Global Riverpod providers, e.g., Database Manager)
│   ├── services/                (Shared services like database management)
│   ├── theme/                   (Global ThemeData, colors, text styles)
│   └── widgets/                 (Globally reusable widgets, e.g., PrimaryButton)
├── features/                    (Encapsulates all code related to a specific feature)
│   ├── loan_calculator/
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │   │   ├── pages/           (e.g., `loan_calculator_page.dart`)
│   │   │   └── widgets/         (e.g., `loan_input_form.dart`)
│   │   └── providers/           (e.g., `loan_calculator_provider.dart`)
├── routes/                      (AutoRoute configuration for app navigation)
├── main.dart                    (App entry point)
```

---

## 2. Presentation Layer & State Management

The presentation layer will use **Riverpod** for state management. For features involving user input and complex state, such as the calculators, a **`Notifier`** will serve as the **`ViewModel`**.

This pattern is a core principle of the architecture for several reasons:
-   **State Encapsulation**: The `Notifier` holds the complete state for its feature (inputs and results).
-   **Logic Isolation**: It orchestrates calls to the domain layer's `UseCases`, keeping business logic separate from the UI.
-   **Improved Testability**: `Notifiers` can be tested independently of the UI, and widgets can be tested with mock providers.
-   **Reactivity**: UI widgets simply listen to the provider and react to state changes, without containing complex logic themselves.

**Example Pattern: `InvestmentCalculatorNotifier`**

```dart
// Located in: lib/features/investment_calculator/providers/investment_calculator_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:personal_finance_calculator/features/investment_calculator/domain/entities/investment_calculation.dart';
import 'package:personal_finance_calculator/features/investment_calculator/domain/usecases/calculate_investment_return_usecase.dart';

// ... (assuming a freezed state class is defined)

@riverpod
class InvestmentCalculatorNotifier extends _$InvestmentCalculatorNotifier {

  @override
  InvestmentCalculation build() {
    // Return the initial state.
    return CalculateInvestmentReturnUseCase().call(
      initialInvestmentCents: 0,
      regularContributionCents: 0,
      contributionFrequency: 'Monthly',
      annualInterestRate: 0.0,
      investmentPeriodYears: 1,
    );
  }

  void calculate({
    required double initialInvestment,
    required double regularContribution,
    // ... other params
  }) {
    final useCase = CalculateInvestmentReturnUseCase();
    final result = useCase.call(
      initialInvestmentCents: (initialInvestment * 100).round(),
      regularContributionCents: (regularContribution * 100).round(),
      // ... other params
    );
    // Update the state, which automatically rebuilds listening widgets.
    state = result;
  }
}
```

---

## 3. Data Models & Entities

**Crucial Decision:** All money-related values will be stored and processed as **`int` (integers representing cents)** to mitigate floating-point inaccuracies.

*   (Entity and Model definitions for `LoanCalculation`, `InvestmentCalculation`, etc., remain here as previously defined.)

---

## 4. Repositories

Repositories abstract data sources, providing a clean interface for the Domain Layer to interact with data.

*   (Repository interfaces and implementations for `LoanCalculation`, `BankRates`, etc., remain here as previously defined.)

---

## 5. Use Cases

Use Cases encapsulate specific business rules and operations.

### 5.1 Investment Calculator Use Case

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
    // Input validation as per requirements
    if (initialInvestmentCents < 0 || initialInvestmentCents >= 9900000000 ||
        regularContributionCents < 0 || regularContributionCents >= 9900000000 ||
        annualInterestRate < 0 || annualInterestRate >= 100 ||
        investmentPeriodYears <= 0 || investmentPeriodYears > 50) {
      throw ArgumentError('Invalid input for investment calculation');
    }
    // ... rest of calculation logic
  }
}
```
*   (Other Use Case definitions remain here as previously defined.)

---

## 6. Technical Specifications & Conventions

### 6.1 Technology Versions

| Package           | Version   | Purpose                       |
| ----------------- | --------- | ----------------------------- |
| `flutter`         | `>=3.10.0`  | Core UI Framework             |
| `flutter_riverpod`| `^2.4.6`  | State Management              |
| `sqflite`         | `^2.3.0`  | Local Database Storage        |
| `path`            | `^1.8.3`  | File System Path Manipulation |
| `intl`            | `^0.18.1` | Internationalization/Formatting |

### 6.2 Frontend Conventions

*   **Responsive Design:** A responsive UI will be achieved using `LayoutBuilder` and `MediaQuery` to adapt to different screen sizes.
*   **Styling:** A central theme will be defined in `lib/core/theme/app_theme.dart` using `ThemeData` to ensure UI consistency.
*   **File Naming:** All Dart files will use `snake_case_with_lowercase.dart`.

### 6.3 Build and Environment Strategy

*   **Debug & Release:** The app will use standard `debug` and `release` build modes. Future environments (e.g., staging) will be managed with build flavors.

---

## 7. Operational & Security Readiness (Future Work)

The following areas are identified as critical for a full production release and will be addressed post-MVP.

### 7.1 Resilience

*   **Retry Policy:** A retry mechanism (e.g., using a package like `retry`) will be implemented for fetching bank rates.
*   **Caching:** A caching layer will be added for API responses to improve performance and handle offline scenarios.

### 7.2 Observability

*   **Logging & Crash Reporting:** A service like **Firebase Crashlytics** or **Sentry** will be integrated for production monitoring.

### 7.3 Security

*   **Local Data Encryption:** The `sqflite` database will be encrypted using a package like `sqflite_sqlcipher`.
*   **API Key Management:** API keys will be injected securely at build time using `--dart-define` to avoid committing them to source control.

---

## 8. QA Strategy

The QA strategy is designed to ensure the quality, reliability, and correctness of the app.

*   (The detailed QA Strategy remains here as previously defined.)
