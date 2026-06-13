---
description: Generate a numbered task plan with file paths and acceptance criteria
agent: orchestrator-main
---

$ARGUMENTS

Produce a task breakdown for the request above. Follow this workflow:

1. **Context** — Read `AGENTS.md`, `docs/SPEC.md`, relevant ADRs in `docs/adr/`, and any existing source files in the affected packages.
2. **Explore** — Use the `explorer` subagent if unsure about existing code structure.
3. **Plan** — Output a numbered list of 3-5 steps. Each step must include:
   - Exact file paths to create or modify
   - Acceptance criteria (test names, expected behavior)
   - The subagent best suited to execute it (coder, tester, architect, reviewer)
4. **Flag** — Mark any step that requires an architectural decision with **[ADR]**.
5. **Delegate** — Ask the user whether to proceed with step 1, and if so, delegate it to the appropriate subagent.

Do not write code yet. Output the plan only.
