---
name: test-writer
description: Write unit, integration, and smoke tests following project conventions. Covers domain logic, adapter behavior, and edge cases.
triggers:
  - "write test"
  - "add tests"
  - "add test coverage"
  - "missing tests"
  - "write unit test"
  - "write integration test"
  - "write smoke test"
  - "test this"
  - "add regression test"
  - "add edge case test"
---

## What I do
- Write unit tests for domain entities, value objects, and domain services
- Write integration tests for REST controllers, JPA repositories, and messaging adapters
- Write smoke tests for application startup and health checks
- Test edge cases: null/blank inputs, boundary values, validation failures
- Test error paths: exceptions, HTTP error responses, transaction rollbacks
- Follow existing test patterns in `src/test/kotlin/com/serg/kitchen/`
- Use proper assertions: AssertJ for fluent assertions, JUnit 5 for lifecycle

## When to use me
Use this whenever new code is written or existing code is modified.

Trigger conditions:
- New domain entity added → write unit tests
- New endpoint added → write integration tests
- New validation rule → add edge case tests
- Bug fix → write a regression test first
- Review flags missing coverage → fill the gap

## Rules
- Test file location must mirror source location:
  - `domain/model/Ingredient.kt` → `test/.../unit/IngredientTest.kt`
  - `adapter/input/rest/IngredientController.kt` → `test/.../integration/IngredientControllerTest.kt`
  - `application/service/IngredientService.kt` → `test/.../unit/IngredientServiceTest.kt`
- Integration tests: use `@SpringBootTest(webEnvironment = RANDOM_PORT)` with `TestRestTemplate` or `WebTestClient`
- Unit tests: no Spring context; instantiate classes directly
- Test naming: `should [expected behavior] when [condition]` using backtick method names
- Use `@Nested` inner classes to group related test cases
- Mock external dependencies (repositories, clients) but never mock the class under test
- One assertion per test when possible; use `assertAll` for related assertions
- Test validation in domain constructors: valid case + each failure case

## Self-review
Before declaring done:
- Run the specific test: `./gradlew test --tests "com.serg.kitchen.unit.IngredientTest"`
- Verify each test tests exactly one thing — no "test everything" mega-tests
- Confirm edge cases are covered: empty, null, zero, negative, max value, boundary
- Check that tests fail for the right reason (temporarily break the production code and re-run)
- Verify no test depends on execution order — each test must be independent
