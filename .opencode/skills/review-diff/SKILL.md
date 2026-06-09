---
name: review-diff
description: Review code changes against SPEC, ADRs, and repository rules. Check for correctness, design adherence, maintainability, and test coverage.
---

## What I do
- Inspect `git diff` and changed files
- Verify changes align with `docs/SPEC.md` and `docs/adr/*.md`
- Check adherence to package architecture (`domain`, `application`, `adapter`, `config`, `shared`)
- Verify tests cover the new or changed behavior
- Run `./gradlew build` to confirm the change compiles and passes tests

## When to use me
Use this after implementing any feature or fix.
Run me before marking a task as complete.

## Rules
- Flag any untested code paths
- Verify dependencies only flow inward (domain has no framework imports)
- Ensure ktlint checks pass
