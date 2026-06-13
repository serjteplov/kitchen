---
name: git-workflow
description: "Manage git operations: atomic commits with conventional messages, branch creation, PR preparation, and pre-commit safety checks."
---

## What I do
- Create focused, atomic commits with conventional commit messages
- Stage only the files relevant to the current change
- Create feature branches from main with descriptive names
- Prepare PRs: review diff, write description, push to remote
- Run pre-commit safety checks: no secrets, no large files, ktlint clean
- Show `git status`, `git diff`, `git log` for transparency before any action
- Roll back or amend safely when needed

## When to use me
Use this when a code change is complete and ready to be committed.

Trigger conditions:
- Feature/fix is done and verified → commit it
- Need to create a branch for a new task
- Ready to open a PR
- Need to inspect what changed or recent history
- Need to revert a commit cleanly

Never use for:
- Force-push, rebase, or destructive operations unless explicitly asked
- Amending commits that have already been pushed
- Interactive rebase or history rewriting

## Rules
- Always show `git status` and `git diff --stat` before staging anything — let the user review
- Commit message format: `type(scope): description`
  - Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `build`, `ci`
  - Scope: optional package or area (e.g., `domain`, `rest`, `db`)
  - Example: `feat(domain): add category field to Ingredient`
- One logical change per commit — do not batch unrelated changes
- Branch naming: `type/description` (e.g., `feat/ingredient-category`, `fix/validation-message`)
- Before committing, run pre-commit checks:
  1. `./gradlew ktlintCheck` — formatting
  2. `rg -i "password|secret|token|key" --include="*.kt" --include="*.yml" --include="*.properties"` — no secrets
  3. `git diff --cached --stat` — confirm only intended files are staged
- Never commit: build output, IDE files, .kotlin/, .opencode/node_modules/
- Before pushing, verify the remote branch doesn't exist yet

## Self-review
Before declaring done:
- Run `git log --oneline -1` — verify the commit message format and content
- Run `git diff HEAD~1 --stat` — verify only expected files changed
- Run `git status` — working tree must be clean (no unstaged changes left behind)
- If pushing, verify `git push --dry-run` succeeds
- Check `.gitignore` covers all generated/build files that were modified

## Example workflow
Committing a feature:
1. `git status` — show what's changed
2. `git diff --stat` — summary of changes
3. `git add src/main/kotlin/.../Ingredient.kt src/test/.../IngredientTest.kt` — stage only relevant files
4. Pre-commit: `./gradlew ktlintCheck` — verify formatting
5. `git commit -m "feat(domain): add category field to Ingredient"`
6. `git log --oneline -1` — verify the commit
7. Report: "Committed `abc1234`: feat(domain): add category field to Ingredient"
