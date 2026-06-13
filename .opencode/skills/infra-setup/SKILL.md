---
name: infra-setup
description: Set up Spring infrastructure: configuration classes, properties/YAML, security, CORS, scheduling, caching, and cross-cutting bean definitions.
triggers:
  - "configure"
  - "configuration"
  - "Spring config"
  - "security config"
  - "CORS"
  - "scheduling"
  - "caching"
  - "application.yml"
  - "properties"
  - "@Configuration"
  - "set up Spring"
  - "bean definition"
---

## What I do
- Create `@Configuration` classes in `config/`
- Add and organize `application.yml` properties with profiles and type-safe binding
- Set up Spring Security: filter chain, authentication, authorization rules
- Configure CORS, content negotiation, HTTP message converters
- Set up scheduling: `@EnableScheduling`, `@Scheduled` tasks
- Configure caching: `@EnableCaching`, cache manager, TTL setup
- Register custom beans: `ObjectMapper`, `RestTemplate`, `WebClient`
- Set up actuator endpoints and health indicators

## When to use me
Use this for any Spring Boot infrastructure or configuration work.

Trigger conditions:
- Need to add a new Spring configuration class
- Setting up Spring Security
- Adding CORS configuration
- Creating a scheduled task
- Setting up caching
- Adding custom Jackson/ObjectMapper configuration
- Enabling actuator endpoints with custom health indicators

Do NOT use for:
- Business logic configuration → belongs in `application/service/`
- Database schema → use `db-migration`
- Logging format → use `logging-tracing`

## Rules
- Place configuration classes in `config/` unless they are adapter-specific:
  - REST config → `config/` (applies to all controllers)
  - Database config → `config/` (applies to all repositories)
  - Security config → `config/SecurityConfig.kt`
- Use `@ConfigurationProperties` with data classes for type-safe property binding
- Profile-specific config: use `application-{profile}.yml` files or `@Profile` annotation
- Never hardcode environment-specific values — use properties with defaults
- Document non-obvious property keys with comments in YAML
- Use `@ConditionalOnProperty` / `@ConditionalOnMissingBean` for optional beans
- Security: deny by default, explicitly permit only what's needed

## Self-review
Before declaring done:
- Run `./gradlew build` — application must start with the new configuration
- Check the Spring Boot auto-configuration report for conflicts:
  - Add `--debug` to bootRun or check actuator `conditions` endpoint
- Verify property binding: use `@ConfigurationProperties` scanning and check no "unbound" warnings
- If security config changed: test that public endpoints are accessible and protected ones are not
- If scheduling added: verify the cron expression is valid (test with a short interval first)
- Run `./gradlew dependencyInsight --configuration runtimeClasspath --dependency spring-boot-starter-security` if adding security — check for version conflicts

## Example workflow
Setting up CORS for development:
1. Create `config/WebConfig.kt` implementing `WebMvcConfigurer`
2. Override `addCorsMappings` with permitted origins from properties
3. Add `cors.allowed-origins` to `application-local.yml`
4. Write integration test: send preflight OPTIONS request, verify CORS headers
5. Run `./gradlew build` — verify no regressions
