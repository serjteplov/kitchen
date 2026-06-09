# AGENTS.md

## Purpose
This repository should be changed in small, atomic, verifiable steps.

## Environment
- OS: Ubuntu 22.04
- Shell: zsh
- Prefer CLI-first workflows.
- Prefer `rg`, `fd`, `jq`, `git diff`, and focused test commands.

## Working rules
- Make one small change-set per task.
- Do not mix refactoring with feature work unless explicitly requested.
- Do not edit unrelated files.
- Do not invent requirements, APIs, or file contents; inspect first.
- Prefer minimal diffs that are easy to review and revert.
- Preserve existing architecture and naming unless the task requires change.
- Never commit secrets, tokens, or environment-specific credentials.

## Task loop
1. Restate the goal in 1-2 sentences.
2. Propose a short plan with 3-5 steps.
3. Execute only the smallest useful step.
4. Run the narrowest relevant verification.
5. Report changed files, commands run, and result.
6. Stop after the requested scope is complete.

## Verification
Always validate with the cheapest meaningful check first:
- targeted test for touched code;
- then linter/formatter for touched files;
- then broader build/test only if required.

If verification fails:
- show the exact failing command;
- summarize the failure in 1-3 bullets;
- propose the smallest next fix.

## Output format
Use this response structure:
1. Goal
2. Plan
3. Changes made
4. Verification
5. Risks / out of scope

## Editing preferences
- Prefer explicit, readable code over clever shortcuts.
- Keep functions small and single-purpose.
- Update nearby docs/comments only when they become inaccurate.
- When changing config or behavior, mention the rollback path.

## Forbidden without explicit request
- broad renames;
- mass formatting;
- dependency upgrades;
- cross-module rewrites;
- destructive data migrations.
