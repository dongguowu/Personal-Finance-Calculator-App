# Personal Finance Calculator App: Product Requirements Document (PRD)

**Version:** 1.3
**Date:** August 07, 2025
**Prepared by:** Gemini (Acting as Product Owner)

---

## 1. MVP Feature Breakdown & User Stories

This document outlines the functional requirements for the Minimum Viable Product (MVP) of the Personal Finance Calculator App, detailed as user stories with acceptance criteria.

**Feature Prioritization:** Loan Calculator > Investment Calculator > Bank Rates Display > History Screen

---

## 2. Non-Functional Requirements (NFRs)

In addition to the user stories, the MVP must adhere to the following technical requirements:

*   **Financial Precision:** All monetary calculations must be performed using a cents-based integer system (`MoneyCents` class) to prevent floating-point inaccuracies.
*   **Platform:** The application must be built with Flutter (v3.24.0+) and Dart (v3.8.0+), ensuring compatibility with both Android and iOS from a single codebase.
*   **User Interface:** The UI will be built using Google's Material Design 3 component library, ensuring a modern and consistent user experience.
*   **Data Persistence:** User-saved calculations will be stored locally on the device using an `sqflite` database.

---

## 3. Feature Requirements

### 3.1. Loan Calculator

**Overall Goal:** Allow users to quickly calculate loan payments and related details based on their inputs, and save these calculations for future reference.

#### User Story 3.1.1: Calculate Basic Loan Payment

*   **As a user,**
*   **I want to enter the loan amount, interest rate, and loan term,**
*   **So that I can see my estimated monthly payment, total interest paid, and total repayment.**

    **Acceptance Criteria (ACs):**
    *   The screen displays input fields for "Loan Amount", "Annual Interest Rate (%)", and "Loan Term (Years)".
    *   Input fields accept numerical values (decimals for amount/rate, integers for term).
    *   As values are entered/changed, the "Monthly Payment", "Total Interest Paid", and "Total Repayment" fields are automatically updated with calculated results.
    *   All financial output values are displayed formatted as currency (e.g., "CA$1,234.56") and are rounded to two decimal places.
    *   Input validation:
        *   Loan Amount must be greater than 0.
        *   Annual Interest Rate must be greater than or equal to 0.
        *   Loan Term (Years) must be greater than 0.
        *   If inputs are invalid, calculation results should default to "CA$0.00" or show an appropriate error message, without crashing.

#### User Story 3.1.2: Save Loan Calculation

*   **As a user,**
*   **I want to be able to save my calculated loan details,**
*   **So that I can easily find and re-access them later in the History screen.**

    **Acceptance Criteria (ACs):**
    *   A "Favorite" or "Save" icon/button (using standard Material 3 components) is visible on the Loan Calculator screen.
    *   When a valid calculation is present, tapping the "Save" icon saves the current loan calculation to local storage.
    *   Upon successful save, the "Save" icon visually changes state (e.g., from an outline to a filled icon) to indicate it's saved.
    *   If the calculation is already saved, tapping the icon should un-save/delete it, and the icon reverts to its unsaved state.
    *   The saved calculation includes a timestamp.
    *   User receives a brief, non-intrusive confirmation (e.g., a Snackbar) upon saving/unsaving.

#### User Story 3.1.3: Recall Last Saved Loan Calculation

*   **As a user,**
*   **I want the Loan Calculator to automatically load my last saved loan calculation,**
*   **So that I don't have to re-enter common loan details every time.**

    **Acceptance Criteria (ACs):**
    *   When the Loan Calculator screen is opened, if a previously saved loan calculation exists, its input fields are pre-filled with the values from the most recently saved one.
    *   The output fields automatically display the calculated results based on the pre-filled inputs.
    *   The "Save" icon is in its "saved" state if the pre-filled calculation matches a saved one.

---

### 3.2. Investment Return Calculator

**Overall Goal:** Enable users to project the future value of their investments and save these projections.

#### User Story 3.2.1: Calculate Basic Investment Return

*   **As a user,**
*   **I want to enter an initial investment, regular contribution, contribution frequency, annual interest rate, and investment period,**
*   **So that I can see the estimated future value, total contributions, and total earnings.**

    **Acceptance Criteria (ACs):**
    *   The screen displays input fields for "Initial Investment", "Regular Contribution", "Annual Interest Rate (%)", and "Investment Period (Years)".
    *   "Contribution Frequency" is a dropdown/selection with options: "Monthly", "Quarterly", "Annually".
    *   All financial output values are displayed formatted as currency (e.g., "CA$1,234.56").
    *   Input validation:
        *   Initial Investment and Regular Contribution must be >= 0.
        *   Annual Interest Rate must be >= 0.
        *   Investment Period (Years) must be > 0.
        *   At least one of Initial Investment or Regular Contribution must be > 0.
        *   If inputs are invalid, results default to "CA$0.00".

#### User Story 3.2.2: Save Investment Calculation

*   **As a user,**
*   **I want to be able to save my calculated investment details,**
*   **So that I can find and re-access them later in the History screen.**

    **Acceptance Criteria (ACs):**
    *   A "Save" icon is visible on the Investment Calculator screen.
    *   Tapping the "Save" icon saves the current investment calculation to local storage.
    *   The icon's state changes to reflect the saved status. Tapping again deletes the saved entry.
    *   User receives a Snackbar confirmation upon saving/unsaving.

---

### 3.3. Bank Rates Display Screen

**Overall Goal:** Provide users with access to Canadian bank rates for various financial products.

**Note:** Data will be sourced from the **Bank of Canada's Valet API**. Displayed products will be dependent on the API's offerings.

#### User Story 3.3.1: View Current Bank Rates

*   **As a user,**
*   **I want to see a list of Canadian bank rates for different financial products (e.g., mortgages, GICs),**
*   **So that I can compare current offerings.**

    **Acceptance Criteria (ACs):**
    *   The "Bank Rates" screen displays a list of bank rate entries.
    *   Each entry shows: Bank Name, Product Name, Interest Rate, and Term.
    *   The screen indicates the time/date the rates were last updated.

#### User Story 3.3.2: Refresh Bank Rates

*   **As a user,**
*   **I want to be able to manually refresh the bank rates,**
*   **So that I can ensure I'm viewing the most up-to-date information.**

    **Acceptance Criteria (ACs):**
    *   The screen supports a "pull-to-refresh" gesture.
    *   A loading indicator is displayed while fetching new rates.
    *   The list and the "last updated" timestamp are updated upon completion.

#### User Story 3.3.3: Handle Loading and Error States for Bank Rates

*   **As a user,**
*   **I want clear feedback when rates are loading or if there is an issue,**
*   **So that I understand the status of the data.**

    **Acceptance Criteria (ACs):**
    *   **Loading State:** A prominent loading indicator is displayed.
    *   **Error State:** If a network or API error occurs, a user-friendly message is shown with a "Retry" button.
    *   **No Data State:** If the API returns no rates, a message like "No bank rates available" is displayed.

---

### 3.4. History Screen

**Overall Goal:** Allow users to view, search, recall, and manage their saved calculations.

#### User Story 3.4.1: View All Saved Calculations

*   **As a user,**
*   **I want to see a combined, sorted list of all my saved calculations,**
*   **So that I can easily browse my financial history.**

    **Acceptance Criteria (ACs):**
    *   The "History" screen lists all saved loan and investment calculations.
    *   Each item indicates the calculation type ("Loan", "Investment"), a summary, and the saved date.
    *   Calculations are sorted in reverse chronological order (newest first).
    *   A message is displayed if no calculations have been saved.

#### User Story 3.4.2: Search and Filter Saved Calculations

*   **As a user,**
*   **I want to search and filter my saved calculations,**
*   **So that I can find specific entries quickly.**

    **Acceptance Criteria (ACs):**
    *   A search bar is present at the top of the screen.
    *   The list dynamically filters as the user types.
    *   Search matches against relevant summary fields (e.g., loan amount, keywords).

#### User Story 3.4.3: Recall Saved Calculation to Calculator

*   **As a user,**
*   **I want to tap on a saved calculation to load it into the correct calculator,**
*   **So that I can review or modify it.**

    **Acceptance Criteria (ACs):**
    *   Tapping a history item navigates to the corresponding calculator (Loan or Investment).
    *   The calculator's input fields are pre-filled with the values from the history item.
    *   The "Save" icon on the calculator is in its "saved" state.

#### User Story 3.4.4: Delete Saved Calculation

*   **As a user,**
*   **I want to remove saved calculations from my history,**
*   **So that I can keep my history clean.**

    **Acceptance Criteria (ACs):**
    *   Each history item has a clear delete option (e.g., swipe-to-delete).
    *   A confirmation dialog appears to prevent accidental deletion.
    *   Upon confirmation, the item is removed from the list and local storage.
