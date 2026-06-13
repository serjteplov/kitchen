---
name: explore-codebase
description: Explore and understand existing code before making changes. Search for patterns, trace dependencies, and produce structured summaries — read-only, no edits.
triggers:
  - "explore the code"
  - "find in codebase"
  - "where is"
  - "how does it work"
  - "show me where"
  - "look up"
  - "search code"
  - "trace the flow"
  - "what is the structure"
  - "find references to"
---

## What I do
- Search for files by glob pattern across the project (e.g., `**/*Controller.kt`)
- Search code content with regex (e.g., `class.*Service`, `@RestController`)
- Read and trace related files to understand structure and dependencies
- Identify existing patterns: naming conventions, package layout, class hierarchies
- Check test coverage for a given area (find corresponding test files)
- Produce a structured summary with exact file paths and line numbers
- Highlight reuse opportunities: existing utilities, base classes, shared types

## When to use me
Use this before implementing anything new — understanding the existing code prevents rework and inconsistency.

Trigger conditions:
- Starting work on an unfamiliar area of the codebase
- Need to find where a concept is already implemented
- Before renaming or moving code (map all references first)
- Answering "how does X work?" or "where is Y defined?"
- Before writing `implement-feature-slice` or `refactor-small-safe`

## Rules
- Never edit files — this skill is strictly read-only
- Prefer `rg` for content search, `glob` for file patterns, `read` for file contents
- When tracing dependencies, start from the entry point and follow inward:
  - REST: controller → application service → domain service → entity
  - Data: entity → JPA repository interface → outbound port
- Always report findings with exact file paths and line numbers
- Flag any violations of hexagonal architecture (e.g., domain importing Spring)
- Check for existing tests before suggesting test additions

## Self-review
Before presenting findings:
- Verify every file path exists by re-reading at least one referenced file
- Confirm no assumptions were made without source evidence
- Cross-check that patterns reported (e.g., "all controllers extend BaseController") are actually consistent across all found files
- If a search returned zero results, explicitly state that — don't silently omit
- Report confidence level: confirmed, pattern-based, or speculative

## Example workflow
1. Search: `rg "@RestController" --include="*.kt"` to find all controllers
2. Read: pick one controller to understand the pattern
3. Trace: follow its injected dependencies to application services
4. Search: `glob "**/test/**"` to find corresponding tests
5. Summarize: "3 controllers found at [...] following pattern X. Test coverage: 2/3 controllers have integration tests."
