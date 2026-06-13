---
name: start-task
description: Read SPEC.md, relevant ADRs, and existing source files. Produce a plan with the files to create or modify, then implement and verify.
---

## What I do
- Read `docs/SPEC.md`, `docs/adr/*.md`, and `AGENTS.md`
- Explore relevant source directories to understand existing patterns
- Produce a numbered plan with exact file paths
- Implement the smallest useful step first
- Verify with `./gradlew build` (or narrower test where possible)

## When to use me
Use this at the start of any new task.
Helps avoid guesswork and ensures context is loaded before coding.

## Rules
- Restate the goal in 1-2 sentences before proposing a plan
- Ask questions to clarify requirements if needed before planning
- Propose 3-5 steps maximum
- Execute only one step at a time, verify, then continue
- DO NOT mix refactoring with feature work
