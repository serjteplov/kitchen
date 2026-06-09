---
description: Run the full Gradle build (compile + test + lint)
agent: build
---

Run the full build for the kitchen project:

```
./gradlew build
```

- If the build fails, show the exact failing task and error.
- Fix root causes one at a time, re-running the build after each fix.
- Do not skip ktlint or test failures; fix them properly.
- Report the final result: all tasks that passed and any remaining issues.
