# Personal Finance Calculator App: Project Brief (MVP)

**Version:** 1.1
**Date:** July 31, 2025

---

## 1. Project Overview & Goal

The Personal Finance Calculator App aims to provide users with a mobile application (Android & iOS) to perform common financial calculations, save their history, and access up-to-date bank interest rates. The core objective is to offer a reliable, accurate, and user-friendly tool for personal finance management.

## 2. Key Features (Minimum Viable Product - MVP Scope)

The first release of the application will focus on the following core functionalities:

1.  **Loan Calculator:** Allows users to calculate estimated monthly payments, total interest paid, and total repayment for a loan based on loan amount, interest rate, and loan term.
2.  **Investment Return Calculator:** Enables users to project the future value of their investments, considering initial investment, regular contributions, interest rates, and investment periods.
3.  **Bank Rates Display Screen:** Provides access to current (or near real-time) Canadian bank interest rates for various financial products.
4.  **History Screen:** A centralized place for users to view, search, recall, and manage all their previously saved loan and investment calculations.

## 3. Core Technologies & Packages

The application will be developed using a modern and robust technology stack and packages:

* **Framework:** Flutter (Latest Stable)
* **Language:** Dart (Latest Stable)
* **UI/UX:** Material Design 3 (Flutter's built-in components)
* **State Management:** Riverpod (`riverpod_annotation`, `flutter_riverpod`)
* **ViewModel:** Riverpod Notifier(with code generation approach (@riverpod))
* **Local Database:** `sqflite` (for persistent storage of calculations)
* **Network Requests:** `http` (for fetching bank rates from an external API)
* **Routing:** `AutoRoute` (for declarative and type-safe navigation)
* **Data Classes/Immutability:** `freezed` and `freezed_annotation` (for creating immutable data models)
* **JSON Serialization:** `json_serializable` and `json_annotation` (for efficient JSON parsing)


## 4. No floating-point errors when dealing with money

**Crucial Decision:** All money-related values will be stored and processed as **`int` (integers representing cents)** to mitigate floating-point inaccuracies.
Use **int** for money values (stored as **cents**) instead of double to avoid floating-point precision issues