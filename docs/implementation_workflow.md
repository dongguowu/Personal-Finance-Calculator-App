# Personal Finance Calculator: Implementation Workflow

## Phase 1: Core Setup & Loan Calculator (MVP Priority 1)

This phase establishes the project foundation and implements the highest-priority feature.

### 1.1 Project & Core Foundation Setup
- **Task:** Initialize Flutter project with specified dependencies (`Riverpod`, `freezed`, `AutoRoute`, `sqflite`, `http`, etc.).
- **Task:** Set up project directory structure according to the Clean Architecture model (`/lib/features`, `/lib/core`).
- **Task:** Implement the `MoneyCents` class for all financial calculations as per `brief.md`.
    - **Testing:** Write unit tests for `MoneyCents` to cover construction, arithmetic, and formatting.
- **Task:** Configure `AutoRoute` for navigation.

### 1.2 Loan Calculator: Domain & Data Layers
- **Task:** Create `LoanCalculation` entity (domain layer) and `LoanCalculationModel` (data layer) using `freezed`.
- **Task:** Define `ILoanRepository` interface (domain layer).
- **Task:** Implement `LoanRepository` (data layer) to interact with a local `sqflite` data source for saving/retrieving calculations.
- **Task:** Create `CalculateLoanPaymentUseCase` to encapsulate the business logic for loan calculations.
    - **Testing:** Write unit tests for the use case.

### 1.3 Loan Calculator: Presentation Layer
- **Task:** Create the `LoanCalculatorPage` UI with Material 3 widgets for inputs (Loan Amount, Rate, Term) and outputs (Monthly Payment, Total Interest, etc.).
- **Task:** Implement `LoanCalculatorNotifier` (ViewModel) using `Riverpod` to manage state, handle user input, and call the use case.
- **Task:** Implement input validation as per PRD ACs.
- **Task:** Implement the "Save/Un-save" functionality, connecting the UI to the repository via the Notifier.
- **Testing:** Write widget tests for `LoanCalculatorPage` and its components.

## Phase 2: Investment Calculator (MVP Priority 2)

### 2.1 Investment Calculator: Domain & Data Layers
- **Task:** Create `InvestmentCalculation` entity and `InvestmentCalculationModel` using `freezed`.
- **Task:** Extend `IInvestmentRepository` and `InvestmentRepository` for saving/retrieving investment calculations.
- **Task:** Create `CalculateInvestmentReturnUseCase`.
    - **Testing:** Write unit tests for the use case.

### 2.2 Investment Calculator: Presentation Layer
- **Task:** Create `InvestmentCalculatorPage` UI with required input fields.
- **Task:** Implement `InvestmentCalculatorNotifier` using `Riverpod`.
- **Task:** Implement "Save" functionality.
- **Testing:** Write widget tests for the page.

## Phase 3: Bank Rates Display (MVP Priority 3)

### 3.1 Bank Rates: Domain & Data Layers
- **Task:** Create `BankRate` entity and model using `freezed`.
- **Task:** Define `IBankRateRepository` interface.
- **Task:** Implement `BankRateRepository` using the `http` package to fetch data from the Bank of Canada Valet API.
- **Task:** Create `FetchBankRatesUseCase`.
    - **Testing:** Unit test with a mocked repository.

### 3.2 Bank Rates: Presentation Layer
- **Task:** Create `BankRatesPage` UI to display a list of rates.
- **Task:** Implement `BankRatesNotifier` to manage state (loading, error, success).
- **Task:** Implement pull-to-refresh functionality.
- **Testing:** Write widget tests for loading, error, and data states.

## Phase 4: History Screen (MVP Priority 4)

### 4.1 History: Domain & Data Layers
- **Task:** Create use cases for fetching, searching, and deleting all saved calculations (`GetHistoryUseCase`, `SearchHistoryUseCase`, `DeleteHistoryItemUseCase`).
- **Task:** Update repositories to support combined fetching and deletion.

### 4.2 History: Presentation Layer
- **Task:** Create `HistoryPage` UI to display a sorted list of saved items.
- **Task:** Implement `HistoryNotifier` to manage and filter the list.
- **Task:** Implement search functionality.
- **Task:** Implement swipe-to-delete with confirmation.
- **Task:** Implement navigation to recall a calculation into its respective calculator page.
- **Testing:** Write widget and integration tests for the full history flow.
