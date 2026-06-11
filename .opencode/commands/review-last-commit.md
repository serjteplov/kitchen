---
description: Review the last commit as a strict senior engineer
agent: senior-reviewer
---

Analyze the last commit and provide a comprehensive code review:

```
git show --stat --patch --format=fuller HEAD
```

## Review Checklist

- **Code Quality**: Readability, naming conventions, complexity, and adherence to project standards
- **Correctness**: Logic errors, edge cases, potential bugs, and null safety
- **Architecture**: Proper layer separation, dependency direction, and design patterns
- **Testing**: Test coverage for changed code, meaningful assertions, and test quality
- **Performance**: Inefficient algorithms, unnecessary allocations, or database queries
- **Security**: Input validation, injection risks, and sensitive data handling

## Review Format

1. **Summary**: Brief overview of the changes and their purpose
2. **Critical Issues**: Blocking problems that must be fixed (if any)
3. **Improvements**: Non-blocking suggestions for better code quality
4. **Positive Aspects**: What was done well (balance is important)

## Guidelines

- Be direct and specific: cite line numbers and file names when referencing issues
- Prioritize actionable feedback: suggest concrete alternatives, not just complaints
- Distinguish preferences from problems: mark stylistic suggestions as `[NIT]`
- Consider context: not all feedback needs to be applied immediately
- For Kotlin code, verify: null safety, idiomatic patterns, and coroutine usage
- For tests, verify: assertions are meaningful and failure messages are clear

If the commit contains migrations or config changes, verify rollback safety and environment compatibility.
