# 6\. QA Strategy

The QA strategy is designed to ensure the quality, reliability, and correctness of the Personal Finance Calculator App, verifying all user story acceptance criteria are met.

## 6.1. Overall Goal

Ensure the Personal Finance Calculator App functions correctly, is reliable, performs well, and meets all defined user requirements for the MVP release.

## 6.2. Core Testing Pillars

1.  **Functional Testing:** Verify each feature (Loan, Investment, Bank Rates, History) performs as per user stories.
2.  **Data Integrity Testing:** Ensure financial calculations are accurate (especially with `int` cents) and data is correctly persisted/retrieved.
3.  **UI/UX Testing:** Confirm intuitive, responsive, visually consistent (Material 3) UI with smooth user experience.
4.  **Performance Testing (Basic):** Ensure app responsiveness and calculation speed.
5.  **Cross-Platform Compatibility Testing (Basic):** Verify core functionality on representative Android/iOS devices/simulators.

## 6.3. Types of Testing

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

## 6.4. Test Planning & Execution

  * **Test Cases:** Develop detailed test cases for each user story's acceptance criteria.
  * **Test Environment:** Utilize emulators/simulators for automated tests. Perform critical manual testing on representative physical devices.
  * **Continuous Integration (CI):** Integrate automated tests into a CI pipeline (e.g., GitHub Actions) to run on every code commit, ensuring early detection of regressions.

<!-- end list -->
