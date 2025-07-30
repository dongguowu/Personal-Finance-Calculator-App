# 1. Architectural Overview: Clean Architecture / Layered Approach

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

---
