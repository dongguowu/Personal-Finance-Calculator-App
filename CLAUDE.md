# Claude Code - Project Memory

This file contains project-specific conventions, configurations, and important instructions for Claude to remember and apply during development.

---

## Git Settings

*   **includeCoAuthoredBy:** false - Do not add the "Co-Authored-By" trailer to git commits.

---

## Testing Conventions

### Test Numbering Convention

Use a hierarchical numbering system for tests to improve organization and searchability:

1.  **Group numbering:** Use `#N000` format for test groups.
    *   `#1000`: Construction and initialization tests
    *   `#2000`: Common operations and functionality tests
    *   `#3000`: Edge cases and error handling tests
    *   `#4000`: Performance and optimization tests
    *   `#5000`: Integration with other components
    *   `#6000`: Boundary tests and validation
    *   `#7000`: Regression tests
    *   `#8000`: Platform-specific tests
    *   `#9000`: Miscellaneous tests

2.  **Test numbering:** Use `#N0XX` format for individual tests.
    *   First digit matches the group number.
    *   Last two digits provide sequential numbering within the group.
    *   Example: `#1001`, `#1002`, `#1003` for the first three tests in group `#1000`.

3.  **Subgroup numbering:** Use `#NN00` format for subgroups.
    *   First digit matches the main group.
    *   Second digit indicates the subgroup.
    *   Example: `#1100`, `#1200` for subgroups within group `#1000`.

### Test Description Guidelines

Use clear, consistent test descriptions that communicate purpose and expectations:

1.  **Test naming pattern:** `'#NNXX: [description of what is being tested]'`
    *   Include the test number at the beginning for easy reference.
    *   Clearly state what the test is verifying.
    *   Example: `test('#1001: fromCents constructor should store the correct cent value', ...)`

2.  **Test structure:**
    *   Use "Arrange/Act/Assert" or "Given/When/Then" comments to structure the test body.
    *   Example:
        ```dart
        test('#2001: should update temperature when increase button pressed', () {
          // Arrange: A temperature controller with initial value
          final controller = TemperatureController(initialValue: 20.0);

          // Act: Increase button is pressed
          controller.increaseTemperature();

          // Assert: Temperature should be increased by 1.0
          expect(controller.temperature, 21.0);
        });
        ```

3.  **Test grouping:**
    *   Group related tests with descriptive names that include the group number.
    *   Example: `group('#2000: Arithmetic Operators', () { ... })`

4.  **Assertion clarity:**
    *   Use descriptive matchers that explain the expectation.
    *   Include a `reason` for complex or non-obvious assertions.
    *   Example: `expect(result, isNotNull, reason: "Result should never be null after initialization");`
