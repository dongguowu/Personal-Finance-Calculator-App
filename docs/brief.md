# Personal Finance Calculator App: Project Brief (MVP)

**Version:** 1.2
**Date:** August 07, 2025

---

## 1. Project Overview & Goal

The Personal Finance Calculator App aims to provide users with a mobile application (Android & iOS) to perform common financial calculations, save their history, and access up-to-date bank interest rates. The core objective is to offer a reliable, accurate, and user-friendly tool for personal finance management.

## 2. Key Features (Minimum Viable Product - MVP Scope)

The first release of the application will focus on the following core functionalities:

1.  **Loan Calculator:** Allows users to calculate estimated monthly payments, total interest paid, and total repayment for a loan based on loan amount, interest rate, and loan term.
2.  **Investment Return Calculator:** Enables users to project the future value of their investments, considering initial investment, regular contributions, interest rates, and investment periods.
3.  **Bank Rates Display Screen:** Provides access to current (or near real-time) Canadian bank interest rates for various financial products.
4.  **History Screen:** A centralized place for users to view, search, recall, and manage all their previously saved loan and investment calculations.

## 3. Core Technologies & External Dependencies

The application will be developed using a modern and robust technology stack:

*   **Framework:** Flutter (v3.24.0 or higher)
*   **Language:** Dart (v3.8.0 or higher)
*   **Linting:** `very_good_analysis` for maintaining high-quality code standards.
*   **UI/UX:** Material Design 3 (Flutter's built-in components). No external design mockups are required for the MVP.
*   **State Management:** Riverpod (`riverpod_annotation`, `flutter_riverpod`)
*   **ViewModel:** Riverpod Notifier (with code generation approach, i.e., `@riverpod`)
*   **Local Database:** `sqflite` for persistent storage of user calculations.
*   **Network Requests:** `http` for fetching data.
*   **Bank Rates API:** Sourced from the Bank of Canada's Valet API: `https://www.bankofcanada.ca/valet/`.
*   **Routing:** `AutoRoute` for declarative and type-safe navigation.
*   **Data Classes/Immutability:** `freezed` and `freezed_annotation` for creating immutable data models.
*   **JSON Serialization:** `json_serializable` and `json_annotation` for efficient JSON parsing.

## 4. Monetary Value Handling

To ensure financial accuracy and avoid floating-point errors, all monetary values will be handled as integers representing cents. A dedicated `MoneyCents` class will be implemented for this purpose, encapsulating all related logic and preventing precision issues throughout the application.

## 5. Quality Assurance

The project will be supported by a comprehensive testing strategy to ensure code quality and application stability. This includes:
*   **Unit Tests:** For business logic and individual functions.
*   **Widget Tests:** To verify UI components in isolation.
*   **Integration Tests:** To ensure seamless interaction between different parts of the app.
## 6. Security & Operational Considerations

To ensure the application is robust and secure, the following areas will be addressed post-MVP as part of the production readiness roadmap:

*   **Local Data Encryption:** The local `sqflite` database will be encrypted to protect sensitive user data.
*   **Secure API Key Management:** API keys will be managed securely using compile-time variables, preventing them from being exposed in the codebase.
*   **Crash Reporting:** A monitoring service will be integrated to detect and diagnose production issues promptly.
*   **API Resilience:** A retry policy will be implemented for API calls to handle transient network issues gracefully.

