---

### File 3: `PRD.md`

```markdown
# Personal Finance Calculator App: Product Requirements Document (PRD)

**Version:** 1.1
**Date:** August 06, 2025
**Prepared by:** Gemini (Acting as Product Owner)

---

## 1. MVP Feature Breakdown & User Stories

This document outlines the functional requirements for the Minimum Viable Product (MVP) of the Personal Finance Calculator App, detailed as user stories with acceptance criteria.

**Feature Prioritization:** Loan Calculator > Investment Calculator > Bank Rates Display > History Screen

---

### 1.1. Loan Calculator

**Overall Goal:** Allow users to quickly calculate loan payments and related details based on their inputs, and save these calculations for future reference.

#### User Story 1: Calculate Basic Loan Payment

* **As a user,**
* **I want to enter the loan amount, interest rate, and loan term,**
* **So that I can see my estimated monthly payment, total interest paid, and total repayment.**

    **Acceptance Criteria (ACs):**
    * The screen displays input fields for "Loan Amount", "Annual Interest Rate (%)", and "Loan Term (Years)".
    * Input fields accept numerical values (decimals for amount/rate, integers for term).
    * As values are entered/changed, the "Monthly Payment", "Total Interest Paid", and "Total Repayment" fields are automatically updated with calculated results.
    * All financial output values (monthly payment, total interest, total repayment) are displayed formatted as currency (e.g., "$1,234.56 CAD") and are rounded to two decimal places.
    * Input validation:
        * Loan Amount must be greater than 0.
        * Annual Interest Rate must be greater than or equal to 0.
        * Loan Term (Years) must be greater than 0.
        * If inputs are invalid, calculation results should default to "$0.00" or show an appropriate error message, without crashing.

#### User Story 2: Save Loan Calculation

* **As a user,**
* **I want to be able to save my calculated loan details,**
* **So that I can easily find and re-access them later in the History screen.**

    **Acceptance Criteria (ACs):**
    * A "Favorite" or "Save" icon/button (as per UX spec) is visible on the Loan Calculator screen.
    * When a valid calculation is present, tapping the "Save" icon saves the current loan calculation (including input parameters and results) to local storage.
    * Upon successful save, the "Save" icon visually changes state (e.g., from outline to filled, as per UX spec) to indicate it's saved.
    * If the calculation is already saved (identified by its unique ID), tapping the icon should un-save/delete it, and the icon reverts to its unsaved state.
    * The saved calculation includes a timestamp of when it was saved.
    * User receives a brief, non-intrusive confirmation (e.g., a Snackbar) upon saving/unsaving.

#### User Story 3: Recall Last Saved Loan Calculation

* **As a user,**
* **I want the Loan Calculator to automatically load my last saved loan calculation when I open the app or navigate to the screen,**
* **So that I don't have to re-enter common loan details every time.**

    **Acceptance Criteria (ACs):**
    * When the Loan Calculator screen is opened (e.g., from app launch or navigating from another tab), if a previously saved loan calculation exists, its input fields (Loan Amount, Interest Rate, Loan Term) are pre-filled with the values from the most recently saved loan calculation.
    * The output fields (Monthly Payment, Total Interest, Total Repayment) automatically display the calculated results based on the pre-filled inputs.
    * The "Save" icon is in its "saved" state if the pre-filled calculation matches a saved one.

---

### 1.2. Investment Return Calculator

**Overall Goal:** Enable users to project the future value of their investments based on initial amounts, regular contributions, interest rates, and investment periods, and to save these projections.

#### User Story 1: Calculate Basic Investment Return

* **As a user,**
* **I want to enter an initial investment, regular contribution, contribution frequency, annual interest rate, and investment period,**
* **So that I can see the estimated future value, total contributions, and total earnings of my investment.**

    **Acceptance Criteria (ACs):**
    * The screen displays input fields for "Initial Investment", "Regular Contribution", "Annual Interest Rate (%)", and "Investment Period (Years)".
    * "Contribution Frequency" is a dropdown/selection with options: "Monthly", "Quarterly", "Annually".
    * Input fields accept numerical values; calculations update dynamically.
    * All financial output values ("Estimated Future Value", "Total Contributions", "Total Earnings") are displayed formatted as currency (e.g., "$1,234.56 CAD") and are rounded to two decimal places.
    * Input validation:
        * Initial Investment must be greater than or equal to 0.
        * Regular Contribution must be greater than or equal to 0.
        * Annual Interest Rate must be greater than or equal to 0.
        * Investment Period (Years) must be greater than 0.
        * At least one of Initial Investment or Regular Contribution must be greater than 0.
        * If inputs are invalid, calculation results should default to "$0.00" or show an appropriate error message, without crashing.

#### User Story 2: Save Investment Calculation

* **As a user,**
* **I want to be able to save my calculated investment details,**
* **So that I can easily find and re-access them later in the History screen.**

    **Acceptance Criteria (ACs):**
    * A "Favorite" or "Save" icon/button is visible on the Investment Calculator screen.
    * When a valid calculation is present, tapping the "Save" icon saves the current investment calculation to local storage.
    * Upon successful save, the "Save" icon visually changes state.
    * If the calculation is already saved, tapping the icon should un-save/delete it, and the icon reverts to its unsaved state.
    * The saved calculation includes a timestamp.
    * User receives a brief, non-intrusive confirmation (e.g., a Snackbar).

#### User Story 3: Recall Last Saved Investment Calculation

* **As a user,**
* **I want the Investment Calculator to automatically load my last saved investment calculation when I open the app or navigate to the screen,**
* **So that I don't have to re-enter common investment details every time.**

    **Acceptance Criteria (ACs):**
    * When the Investment Calculator screen is opened, if a previously saved investment calculation exists, its input fields are pre-filled with the values from the most recently saved one.
    * The output fields automatically display results based on the pre-filled inputs.
    * The "Save" icon is in its "saved" state if the pre-filled calculation matches a saved one.

---

### 1.3. Bank Rates Display Screen

**Overall Goal:** Provide users with access to real-time (or near real-time) Canadian bank rates for various financial products.

#### User Story 1: View Current Bank Rates

* **As a user,**
* **I want to see a list of Canadian bank rates for different financial products (e.g., mortgages, GICs),**
* **So that I can compare current offerings from various institutions.**

    **Acceptance Criteria (ACs):**
    * The "Bank Rates" screen displays a list of bank rate entries.
    * Each entry clearly shows: Bank Name, Product Name, Interest Rate (formatted as percentage), Term (e.g., "5 years", "12 months").
    * Rates are presented in a clear, readable format (e.g., cards or list items).
    * The screen indicates the time/date the displayed rates were last updated (e.g., "Rates last updated: July 30, 2025, 3:47 PM").

#### User Story 2: Refresh Bank Rates

* **As a user,**
* **I want to be able to manually refresh the bank rates,**
* **So that I can ensure I'm viewing the most up-to-date information.**

    **Acceptance Criteria (ACs):**
    * The screen supports a "pull-to-refresh" gesture.
    * Upon pulling down, a loading indicator is displayed while new rates are being fetched.
    * Once new rates are fetched, the list updates automatically.
    * The "last updated" timestamp is updated to reflect the new data's timestamp.

#### User Story 3: Handle Loading and Error States for Bank Rates

* **As a user,**
* **I want clear feedback when bank rates are loading or when there's an issue fetching them,**
* **So that I understand the status of the data.**

    **Acceptance Criteria (ACs):**
    * **Loading State:** When bank rates are being fetched, a prominent loading indicator is displayed.
    * **No Internet/Network Error:** If there's no internet connection or a network error occurs, a user-friendly message is displayed (e.g., "No internet connection. Please check your network settings and try again.") along with a "Retry" button.
    * **API Error:** If the API returns an error (e.g., server down, invalid response), a user-friendly message is displayed (e.g., "Could not fetch rates. Please try again later.") along with a "Retry" button.
    * **No Data:** If the API returns an empty list, a message indicating no rates are available is displayed (e.g., "No bank rates available at this time.").

---

### 1.4. History Screen

**Overall Goal:** Allow users to view, search, recall, and manage all their saved loan and investment calculations.

#### User Story 1: View All Saved Calculations

* **As a user,**
* **I want to see a combined list of all my saved loan and investment calculations,**
* **So that I can easily browse my financial history.**

    **Acceptance Criteria (ACs):**
    * The "History" screen displays a list of all calculations previously saved from both the Loan and Investment calculators.
    * Each item in the list clearly indicates:
        * The type of calculation (e.g., "Loan", "Investment").
        * A concise summary (e.g., "Loan: $150,000 @ 3.5% for 25 yrs", "Inv: $5,000 + $100/mo @ 6% for 10 yrs").
        * The date/time it was saved (e.g., "Saved: July 29, 2025").
    * Calculations are sorted in reverse chronological order by their `savedAt` timestamp (newest first).
    * If no calculations have been saved, a friendly message is displayed (e.g., "No saved calculations yet. Save a calculation from the Loan or Investment tab!").

#### User Story 2: Search and Filter Saved Calculations

* **As a user,**
* **I want to be able to search and filter my saved calculations,**
* **So that I can quickly find specific entries without scrolling through a long list.**

    **Acceptance Criteria (ACs):**
    * A search bar is visible at the top of the History screen.
    * As the user types in the search bar, the list of history items dynamically updates to show only items matching the query.
    * Search should match against relevant fields in the calculation summary (e.g., loan amount, interest rate, keywords like "loan", "investment").
    * A "clear search" button is available in the search bar.

#### User Story 3: Recall Saved Calculation to Calculator

* **As a user,**
* **I want to be able to tap on a saved calculation in the history,**
* **So that I can quickly load its details back into the corresponding calculator screen for review or modification.**

    **Acceptance Criteria (ACs):**
    * Tapping on a Loan calculation in the history list navigates the user to the Loan Calculator screen.
    * Tapping on an Investment calculation in the history list navigates the user to the Investment Calculator screen.
    * Upon navigation, the respective calculator's input fields are pre-filled with the exact values from the selected history item.
    * The calculator's output fields automatically display results based on the pre-filled inputs.
    * The "Save" icon on the calculator screen is in its "saved" state for the recalled calculation.

#### User Story 4: Delete Saved Calculation

* **As a user,**
* **I want to be able to remove saved calculations from my history,**
* **So that I can keep my history clean and relevant.**

    **Acceptance Criteria (ACs):**
    * Each history item has a clear option to delete it (e.g., a swipe-to-delete gesture, or a trash can icon on the item).
    * Upon attempting to delete, a confirmation dialog appears to prevent accidental deletion (e.g., "Are you sure you want to delete this calculation?").
    * If confirmed, the item is removed from the history list and from local storage.
    * The history list updates immediately to reflect the deletion.
    * A brief, non-intrusive confirmation (e.g., a Snackbar) appears upon successful deletion.
````
