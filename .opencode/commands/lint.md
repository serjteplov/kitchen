---
description: Run ktlint checks on the project
agent: build
---

Run ktlint checks on the kitchen project:

```
./gradlew ktlintCheck
```

- Show any style violations found.
- Auto-fix them with `./gradlew ktlintFormat` where possible.
- For violations that cannot be auto-fixed, edit the files manually.
- Re-run the check after fixing to confirm clean.
