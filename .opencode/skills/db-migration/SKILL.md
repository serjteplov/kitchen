---
name: db-migration
description: Create Flyway migrations in src/main/resources/db/migration/ using semantic versioning.
---

## What I do
- Create SQL migration files with versioned names (e.g., `V2__add_users_table.sql`)
- Ensure migrations are backward-compatible
- Review existing schema before writing new migrations

## When to use me
Use this when adding or modifying database tables, indexes, or constraints.
Always check `src/main/resources/db/migration/` for the latest version number first.

## Rules
- Use semantic versioning: `V<number>__<description>.sql`
- Never modify existing migrations; always create a new one
- Test migrations with H2 in development before committing
