---
name: implement-feature-slice
description: Add or modify a small, surgical slice within existing architecture. Unlike spring-feature (greenfield), this skill modifies existing code: add a field, endpoint, service method, or migration.
triggers:
  - "add field to"
  - "add method to"
  - "modify existing"
  - "extend entity"
  - "add to controller"
  - "add column"
  - "update entity"
  - "add property"
  - "add parameter"
  - "add validation"
---

## What I do
- Add a field to an existing domain entity with validation
- Add a method to an existing application service
- Add an endpoint to an existing REST controller
- Add a new outbound port method and repository implementation
- Add a Flyway migration for schema changes
- Write or update tests for the modified slice
- Ensure the change follows hexagonal architecture: domain ← application ← adapter

## When to use me
Use this for surgical changes within existing features — not for greenfield features.

Trigger conditions:
- "Add a `category` field to `Ingredient`"
- "Add a search endpoint to the recipe controller"
- "Add a `findByName` method to the ingredient repository"
- "Add a column to the ingredients table"
- "Update the validation in `Ingredient` to allow negative quantities"

Do NOT use for:
- Brand new entities/endpoints from scratch → use `spring-feature`
- Pure refactoring (no behavior change) → use `refactor-small-safe`
- Pure testing (no production code change) → use `test-writer`

## Rules
- Read the existing code before changing it — understand the pattern first
- Match existing naming conventions, annotations, and code style exactly
- Domain classes must have no Spring or framework imports — validate in init blocks
- Use constructor injection in services and adapters
- Prefer immutable data classes for domain objects
- Start from the innermost layer: domain → application → adapter
- Update tests in the same change — never leave tests broken
- Keep diffs minimal: one conceptual change per slice

## Self-review
Before declaring done:
- Run `./gradlew build` — it must compile and pass all tests
- Run `./gradlew ktlintCheck` — no formatting violations
- Verify the hexagon: domain imports only Kotlin stdlib; application imports domain; adapter imports application + Spring
- Check that existing tests still pass (no regressions)
- Verify new code follows the same patterns as existing code in the same package

## Example workflow
Adding a `category` field to `Ingredient`:
1. Read `domain/model/Ingredient.kt` — understand current structure
2. Add `val category: String` with `require(category.isNotBlank())` in init
3. Read `IngredientTest.kt` — understand test patterns
4. Add test cases for the new field (valid, blank, etc.)
5. If persisted: create Flyway migration adding the column
6. If exposed via API: update the controller DTO and response mapping
7. Run `./gradlew build` — verify everything passes
