---
name: refactor-small-safe
description: Perform small, safe refactoring operations: rename, extract, move, inline. Each change is verified immediately — compile, tests, architecture rules.
triggers:
  - "rename"
  - "refactor"
  - "extract method"
  - "extract interface"
  - "move class"
  - "move package"
  - "inline"
  - "restructure"
  - "change signature"
  - "reorder parameters"
  - "pull up"
  - "push down"
---

## What I do
- Rename classes, methods, variables, or packages
- Extract methods, interfaces, or constants
- Move classes between packages while updating imports
- Inline redundant methods or variables
- Reorder parameters, change signatures with call-site updates
- Restructure code without changing observable behavior

## When to use me
Use this for pure refactoring — no behavior changes, no new features.

Trigger conditions:
- "Rename `findByName` to `findByNameIgnoreCase`"
- "Extract `validateQuantity` method from `Ingredient.init`"
- "Move `Ingredient` from `domain/model/` to `domain/model/ingredient/`"
- "Extract `Quantity` value object from `Ingredient` fields"
- "Inline the `toDto()` helper — it's only used once"

Do NOT use for:
- Adding new behavior → use `implement-feature-slice`
- Fixing bugs → use `implement-feature-slice`
- Adding new features → use `spring-feature`

## Rules
- One refactoring operation per change — do not rename AND extract AND move in one step
- Before renaming, search for ALL references: `rg "OldName" --include="*.kt"`
- After each operation, immediately verify:
  1. `./gradlew compileKotlin` — must compile
  2. `./gradlew test` — all tests must pass
  3. `./gradlew ktlintCheck` — formatting must be clean
- When moving between packages, verify no cyclic dependencies are introduced
- Update imports in test files too — they reference production code paths
- If a refactoring spans more than 5 files, consider it a "large" refactoring and ask for explicit confirmation
- Preserve existing comments and documentation — update only if they become inaccurate

## Self-review
Before declaring done:
- Run the full build: `./gradlew build` — compile, test, lint
- Run `git diff --stat` — verify only intended files changed
- Run `rg "OldName" --include="*.kt"` — must return zero results (for renames)
- Check the hexagon: verify no new cross-layer imports appeared
- Verify test file paths still mirror source file paths

## Example workflow
Renaming `Ingredient.unit` to `Ingredient.measurementUnit`:
1. Search: `rg "\.unit\b" --include="*.kt"` — find all references
2. Apply rename in the domain entity first
3. Update all references in services, controllers, DTOs, tests
4. Compile: `./gradlew compileKotlin` — catch any missed references
5. Test: `./gradlew test` — verify behavior unchanged
6. Search again: `rg "\.unit\b" --include="*.kt"` — must be empty
7. Report: "Renamed `unit` to `measurementUnit` in 5 files. Build passes. Zero remaining references."
