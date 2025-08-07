# Personal Finance Calculator App: Technical Architecture Document

**Version:** 1.3
**Date:** August 07, 2025

---

## 1. Architectural Overview: Clean Architecture / Layered Approach
(Content remains the same)

---

## 2. Presentation Layer & State Management
(Content remains the same)

---

## 3. Shared Services: `IDatabaseManager`
(Content remains the same)

---

## 4. Data Models & Entities
(Content remains the same)

---

## 5. Repositories
(Content remains the same)

---

## 6. Use Cases
(Content remains the same)

---

## 7. Technical Specifications & Conventions
(Content remains the same)

---

## 8. Operational & Security Readiness (Future Work)

The following areas are identified as critical for a full production release and will be addressed post-MVP to ensure the application is secure, reliable, and maintainable.

### 8.1 Security

*   **Local Data Encryption:**
    *   **Risk:** Sensitive financial calculations are stored in the local `sqflite` database in plain text, posing a privacy risk if a user's device is compromised.
    *   **Plan:** The database will be encrypted using the `sqflite_sqlcipher` package, which provides strong AES-256 encryption for the entire database file.

*   **API Key Management:**
    *   **Risk:** Hardcoding API keys in the source code is a major security vulnerability.
    *   **Plan:** API keys will be injected securely at build time using the `--dart-define` flag. This separates secrets from the codebase, allowing them to be managed in a secure environment (e.g., CI/CD secrets).

### 8.2 Observability

*   **Logging & Crash Reporting:**
    *   **Risk:** Without visibility into production issues, diagnosing and fixing bugs that users encounter is nearly impossible.
    *   **Plan:** A service like **Firebase Crashlytics** or **Sentry** will be integrated. This will provide automated crash reporting, stack traces, and device information to enable rapid debugging of production issues.

### 8.3 Resilience

*   **API Retry Policy:**
    *   **Risk:** Mobile network connections can be unstable. A single failed API call can unnecessarily disrupt the user experience.
    *   **Plan:** A retry mechanism will be implemented for fetching bank rates, likely using a package like `retry`. This will make the app more resilient to transient network errors by automatically retrying failed requests.

---

## 9. QA Strategy

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
