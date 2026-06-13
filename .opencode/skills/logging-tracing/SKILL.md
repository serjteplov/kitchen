---
name: logging-tracing
description: Set up structured logging, MDC context propagation, correlation IDs, and request/response observability for debugging in production.
triggers:
  - "logging"
  - "log format"
  - "correlation ID"
  - "MDC"
  - "structured logging"
  - "tracing"
  - "observability"
  - "logback"
  - "log level"
  - "request logging"
---

## What I do
- Configure structured logging: JSON format for production, readable for development
- Set up MDC (Mapped Diagnostic Context) with correlation ID, user ID, request path
- Add correlation ID generation and propagation via HTTP headers (`X-Correlation-Id`)
- Configure request/response logging with appropriate detail (no secrets, no large bodies)
- Set up log levels per package: DEBUG for application, INFO for framework, WARN for noisy libs
- Add timing/performance logging for slow operations
- Integrate with Spring Boot Actuator for log level management at runtime

## When to use me
Use this early — before you need to debug a production incident.

Trigger conditions:
- First endpoint is created → add correlation ID filter
- Moving beyond development → switch to structured logging
- Need to debug request flow across services → add trace context
- Setting up production monitoring → configure log aggregation format
- Performance issues → add timing metrics to key operations

## Rules
- Correlation ID pattern: generate UUID on first request, read from `X-Correlation-Id` header if present
- MDC keys: use consistent naming (snake_case): `correlation_id`, `user_id`, `request_path`, `method`
- Log format:
  - Development: Spring Boot default (human-readable, colored)
  - Production: JSON (Logstash encoder) with MDC fields inlined
- Request logging: log method, path, status, duration — never log request/response bodies by default (PII risk)
- Use `logback-spring.xml` (already present in project) — configure profiles with `<springProfile>`
- Log levels:
  - `com.serg.kitchen`: DEBUG (application code)
  - `org.springframework`: INFO
  - `org.hibernate`: WARN
- Add `@Slf4j` or companion object logger to all service and adapter classes
- Never log sensitive data: passwords, tokens, PII (names, emails in production)
- Use parameterized logging: `log.info("Processing ingredient: {}", name)` — not string concatenation

## Self-review
Before declaring done:
- Start the application: `./gradlew bootRun --args='--spring.profiles.active=local'`
- Make a sample HTTP request and inspect the console output:
  - Correlation ID present in every log line for the request
  - No duplicate correlation IDs across requests
- Check log format: JSON for production profile, readable for local profile
- Verify no sensitive data in logs (search for "password", "token", "authorization" in output)
- Run integration tests — verify correlation ID appears in test logs too
- Test with concurrent requests (e.g., `ab -n 10 -c 5`) — each request gets unique correlation ID

## Example workflow
Adding correlation ID support:
1. Create `config/CorrelationIdFilter.kt` — `OncePerRequestFilter` that reads/generates correlation ID
2. Configure MDC in filter: `MDC.put("correlation_id", correlationId)`
3. Update `logback-spring.xml` to include `%X{correlation_id}` in log pattern
4. Write integration test: send request, verify response header contains `X-Correlation-Id`
5. Run `./gradlew build` — verify tests pass
6. Check console output: correlation ID visible in log lines
