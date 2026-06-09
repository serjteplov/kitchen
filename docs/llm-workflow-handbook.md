# LLM workflow handbook

## Planning
- Read SPEC.md, ADR documents, and relevant source files before implementing
- Break work into small, verifiable steps
- Use the hexagonal architecture package structure: domain, application, adapter, config, shared

## Implementation
- Constructor injection only (per spring-style rules)
- Keep adapters thin; business logic lives in application/domain layers
- Prefer immutable values and explicit null-handling (per kotlin-style rules)

## Testing
- Unit tests for domain/application logic
- Integration tests for adapters (REST, persistence, messaging)
- Smoke test for application startup

## Review
- Verify against SPEC and ADR documents
- Check for correctness, design, maintainability, and regressions
- Ensure code quality checks pass (ktlint)
