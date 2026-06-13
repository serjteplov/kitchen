---
name: adr-writer
description: Create and maintain Architecture Decision Records. Generate from templates, update existing ADRs, and verify code matches documented decisions.
triggers:
  - "ADR"
  - "architecture decision"
  - "decision record"
  - "document decision"
  - "create ADR"
  - "record decision"
  - "architectural decision"
  - "record architecture"
---

## What I do
- Create new ADRs in `docs/adr/` following the numbered naming convention
- Use the project's ADR template (from existing ADRs like `0001-project-structure.md`)
- Write clear Context, Decision, and Consequences sections
- Update existing ADRs when decisions change or are superseded
- Cross-reference related ADRs
- Verify that code matches documented architecture decisions
- Keep ADRs concise and focused — one decision per record

## When to use me
Use this whenever an architectural decision is made or changed.

Trigger conditions:
- Choosing a library, framework, or tool (e.g., "Use Testcontainers for integration tests")
- Defining a pattern or convention (e.g., "Use data classes for DTOs")
- Changing package structure or module boundaries
- Adding a new integration pattern (e.g., "Use outbox pattern for events")
- Adopting a new coding standard that affects architecture
- Superseding a previous decision

Do NOT use for:
- Feature specifications → belongs in `docs/SPEC.md`
- API documentation → belongs in code comments or OpenAPI specs
- Commit messages or PR descriptions

## Rules
- File naming: `docs/adr/NNNN-title-with-hyphens.md` (4-digit number, zero-padded)
- Find the next available number: `ls docs/adr/*.md | sort | tail -1`
- Template structure:
  ```markdown
  # ADR NNNN: Title

  ## Status
  Proposed | Accepted | Deprecated | Superseded by [ADR NNNN]

  ## Context
  What is the situation? What forces are at play? Why is a decision needed?

  ## Decision
  What did we decide? Be specific and concrete.

  ## Consequences
  What becomes easier? What becomes harder? What are the risks?
  ```
- Keep Context under 10 lines, Decision under 10 lines, Consequences under 5 bullets
- Reference related ADRs by number: `[ADR 0001](0001-project-structure.md)`
- When superseding: update the old ADR's Status to "Superseded by ADR NNNN"
- ADRs are immutable once merged — amend via new ADR, not by editing old ones
- Place ADRs that affect architecture in `docs/adr/`, not in `.opencode/skills/` or inline

## Self-review
Before declaring done:
- Verify the ADR number doesn't conflict: `ls docs/adr/ | grep NNNN` must return nothing
- Read the new ADR: does the Decision section say *what* we decided, not *how we feel*?
- Check cross-references: do all mentioned ADR numbers actually exist?
- If this ADR supersedes another, verify the old ADR's Status line was updated
- If this ADR documents a code convention, spot-check 2-3 files to verify code follows it
- Run `git diff --stat` — only new/updated ADR files should be changed

## Example workflow
Creating ADR 0002 for error handling:
1. `ls docs/adr/*.md | sort | tail -1` → `docs/adr/0001-project-structure.md`
2. Create `docs/adr/0002-error-handling.md`
3. Write: Status=Accepted, Context=need consistent error responses, Decision=use RFC 7807 Problem Details, Consequences=standard format but requires exception hierarchy
4. Verify no number conflict, read Decision for clarity
5. Report: "Created ADR 0002: Error handling with RFC 7807 Problem Details"
