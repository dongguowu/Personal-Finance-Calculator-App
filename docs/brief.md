# Personal Finance Calculator App: Project Brief (MVP)

**Version:** 1.0
**Date:** July 30, 2025

---

## 1. Project Overview & Goal

The Personal Finance Calculator App aims to provide users with a mobile application (Android & iOS) to perform common financial calculations, save their history, and access up-to-date bank interest rates. The core objective is to offer a reliable, accurate, and user-friendly tool for personal finance management.

## 2. Key Features (Minimum Viable Product - MVP Scope)

The first release of the application will focus on the following core functionalities:

1.  **Loan Calculator:** Allows users to calculate estimated monthly payments, total interest paid, and total repayment for a loan based on loan amount, interest rate, and loan term.
2.  **Investment Return Calculator:** Enables users to project the future value of their investments, considering initial investment, regular contributions, interest rates, and investment periods.
3.  **Bank Rates Display Screen:** Provides access to current (or near real-time) Canadian bank interest rates for various financial products.
4.  **History Screen:** A centralized place for users to view, search, recall, and manage all their previously saved loan and investment calculations.

## 3. Core Technologies

The application will be developed using a modern and robust technology stack:

* **Framework:** Flutter (Latest Stable)
* **Language:** Dart (Latest Stable)
* **UI/UX:** Material Design 3 (Flutter's built-in components)
* **State Management:** Riverpod (`riverpod_annotation`, `flutter_riverpod`)
* **Local Database:** `sqflite` (for persistent storage of calculations)
* **Network Requests:** `http` (for fetching bank rates from an external API)
* **Routing:** `AutoRoute` (for declarative and type-safe navigation)
* **Data Classes/Immutability:** `freezed` and `freezed_annotation` (for creating immutable data models)
* **JSON Serialization:** `json_serializable` and `json_annotation` (for efficient JSON parsing)

**`pubspec.yaml` implications (key packages):**

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  flutter_riverpod: ^latest_version # e.g., ^2.5.1
  riverpod_annotation: ^latest_version # e.g., ^2.3.0
  sqflite: ^latest_version # e.g., ^2.3.2
  path: ^latest_version # e.g., ^1.9.0
  http: ^latest_version # e.g., ^1.2.1
  freezed_annotation: ^latest_version # e.g., ^2.4.0
  json_annotation: ^latest_version # e.g., ^4.9.0
  auto_route: ^latest_version # e.g., ^7.9.0
  intl: ^latest_version # For currency formatting e.g., ^0.18.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^latest_version # e.g., ^3.0.0
  build_runner: ^latest_version # e.g., ^2.4.8
  riverpod_generator: ^latest_version # e.g., ^2.3.0
  freezed: ^latest_version # e.g., ^2.4.7
  json_serializable: ^latest_version # e.g., ^6.7.1
  auto_route_generator: ^latest_version # e.g., ^7.3.2
  mockito: ^latest_version # e.g., ^5.4.4
