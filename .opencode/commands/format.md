---
description: Auto-format Kotlin source files with ktlint
agent: build
---

Format all Kotlin source files in the kitchen project:

```
./gradlew ktlintFormat
```

- Run the formatter and report any files that were changed.
- If formatting fails on specific files, inspect them and fix manually.
- Follow up with `./gradlew build` to verify everything still compiles and passes.
