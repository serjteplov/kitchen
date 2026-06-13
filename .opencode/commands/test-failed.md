---
description: Analyze the last test run failures without re-running the full suite
agent: build
---

Analyze the most recent test failures in the kitchen project:

1. **Find reports** — Check for existing test results:
   - XML: `build/test-results/test/`
   - HTML: `build/reports/tests/test/`
   - If no reports exist, note this and suggest running `/test` first. Stop here if no reports.
2. **Parse failures** — For each failing test case, extract from the XML:
   - Test class name and method name
   - Assertion error message
   - Stack trace (shortened to project-relevant frames)
3. **Diagnose** — For each failure, read the test class and the code under test. Identify the root cause.
4. **Propose fixes** — For each failure, suggest the smallest fix that addresses the root cause. Include the exact file:line to change.
5. **Prioritize** — Sort failures: assertion errors first (likely bugs), then unexpected exceptions (likely integration issues), then test infra issues.
6. **Ask** — Present the user a choice of which failure to fix first. Do not apply fixes until the user selects one.
