#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="${1:-kitchen}"
BASE_PACKAGE="${2:-com/serg/kitchen}"
BASE_PACKAGE_DOT="${BASE_PACKAGE//\//.}"

cd "$PROJECT_ROOT"

mkdir -p \
  .opencode/agents \
  .opencode/hooks \
  .opencode/rules \
  .opencode/skills/api-integrator \
  .opencode/skills/db-migration \
  .opencode/skills/review-diff \
  .opencode/skills/spring-feature \
  .opencode/skills/start-task \
  docs/adr \
  docs/architecture \
  .github/workflows \
  gradle/wrapper \
  src/main/kotlin/"$BASE_PACKAGE"/config \
  src/main/kotlin/"$BASE_PACKAGE"/domain \
  src/main/kotlin/"$BASE_PACKAGE"/application/port/in \
  src/main/kotlin/"$BASE_PACKAGE"/application/port/out \
  src/main/kotlin/"$BASE_PACKAGE"/application/service \
  src/main/kotlin/"$BASE_PACKAGE"/adapter/input/rest \
  src/main/kotlin/"$BASE_PACKAGE"/adapter/output/client \
  src/main/kotlin/"$BASE_PACKAGE"/adapter/output/messaging \
  src/main/kotlin/"$BASE_PACKAGE"/adapter/output/persistence \
  src/main/kotlin/"$BASE_PACKAGE"/shared \
  src/main/resources/db/migration \
  src/test/kotlin/"$BASE_PACKAGE"/architecture \
  src/test/kotlin/"$BASE_PACKAGE"/integration \
  src/test/kotlin/"$BASE_PACKAGE"/smoke \
  src/test/kotlin/"$BASE_PACKAGE"/unit \
  src/test/resources \
  scripts

cat > AGENTS.md <<'AGENTS'
# AGENTS.md

Project guidance for OpenCode agents.
AGENTS

cat > .opencode/agents/architect.md <<'EOF2'
# Architect agent
Focus on architecture, boundaries, ADRs, and trade-offs.
EOF2

cat > .opencode/agents/coder.md <<'EOF2'
# Coder agent
Implement features according to SPEC, ADRs, and repository rules.
EOF2

cat > .opencode/agents/reviewer.md <<'EOF2'
# Reviewer agent
Review changes for correctness, design, maintainability, and regressions.
EOF2

cat > .opencode/agents/tester.md <<'EOF2'
# Tester agent
Validate unit, integration, and architecture coverage for each change.
EOF2

cat > .opencode/hooks/block-dangerous-commands.sh <<'EOF2'
#!/usr/bin/env bash
set -euo pipefail
exit 0
EOF2

cat > .opencode/hooks/format-and-check.sh <<'EOF2'
#!/usr/bin/env bash
set -euo pipefail
./gradlew ktlintFormat detekt test
EOF2

cat > .opencode/hooks/git-push-reminder.sh <<'EOF2'
#!/usr/bin/env bash
set -euo pipefail
echo "Remember to review CI status before push."
EOF2

cat > .opencode/hooks/inject-git-context.sh <<'EOF2'
#!/usr/bin/env bash
set -euo pipefail
git status --short || true
EOF2

cat > .opencode/hooks/protect-files.sh <<'EOF2'
#!/usr/bin/env bash
set -euo pipefail
exit 0
EOF2

chmod +x .opencode/hooks/*.sh

cat > .opencode/rules/git-workflow.md <<'EOF2'
# Git workflow
- Small commits
- Conventional commits
- Green CI before merge
EOF2

cat > .opencode/rules/kotlin-style.md <<'EOF2'
# Kotlin style
- Prefer immutable values
- Keep functions small
- Use explicit null-handling
EOF2

cat > .opencode/rules/spring-style.md <<'EOF2'
# Spring style
- Constructor injection only
- Keep adapters thin
- Business logic belongs in application/domain layers
EOF2

cat > .opencode/rules/repository-map.md <<'EOF2'
# Repository map
- src/main/kotlin: app code
- src/main/resources: Spring config and migrations
- src/test/kotlin: tests by type
EOF2

cat > .opencode/rules/testing.md <<'EOF2'
# Testing
- Unit tests for domain/application logic
- Integration tests for adapters
- Smoke test for app startup
EOF2

cat > .opencode/rules/architecture.md <<'EOF2'
# Architecture
Use package boundaries similar to hexagonal architecture: domain, application, adapter, config, shared.
EOF2

for skill in api-integrator db-migration review-diff spring-feature start-task; do
  cat > ".opencode/skills/${skill}/SKILL.md" <<EOF2
# ${skill}
Project-specific OpenCode skill placeholder.
EOF2
done

cat > .opencode/settings.json <<'EOF2'
{
  "project": "kitchen",
  "stack": ["kotlin", "spring-boot", "gradle"],
  "notes": "OpenCode local project settings"
}
EOF2

cat > docs/adr/0001-project-structure.md <<'EOF2'
# ADR 0001: Project structure

We use a single-module Kotlin/Spring structure with clear package boundaries to keep early development simple while preserving evolution toward modularization.
EOF2

cat > docs/architecture/context.md <<'EOF2'
# Context
Describe external actors, upstream systems, and downstream systems here.
EOF2

cat > docs/architecture/containers.md <<'EOF2'
# Containers
Describe runtime containers/services here.
EOF2

cat > docs/architecture/components.md <<'EOF2'
# Components
Describe internal application components here.
EOF2

cat > docs/llm-workflow-handbook.md <<'EOF2'
# LLM workflow handbook
Document how OpenCode agents should plan, implement, test, and review tasks.
EOF2

cat > docs/SPEC.md <<'EOF2'
# SPEC

## Goal
Describe the product goal.

## Scope
Describe current scope and non-goals.
EOF2

cat > docs/structure.txt <<EOF2
Generated bootstrap structure for ${PROJECT_ROOT}
Base package: ${BASE_PACKAGE_DOT}
EOF2

cat > .env.example <<'EOF2'
SPRING_PROFILES_ACTIVE=local
SERVER_PORT=8080
EOF2

cat > .gitignore <<'EOF2'
.gradle/
build/
out/
.idea/
*.iml
.env
*.log
.DS_Store
EOF2

cat > .github/workflows/ci.yml <<'EOF2'
name: CI
on:
  push:
  pull_request:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '21'
      - uses: gradle/actions/setup-gradle@v4
      - run: ./gradlew check
EOF2

cat > .github/workflows/dependency-review.yml <<'EOF2'
name: Dependency Review
on:
  pull_request:
jobs:
  dependency-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/dependency-review-action@v4
EOF2

cat > .editorconfig <<'EOF2'
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 4
trim_trailing_whitespace = true

[*.md]
trim_trailing_whitespace = false
EOF2

cat > CODEOWNERS <<'EOF2'
* @your-github-user
EOF2

cat > LICENSE <<'EOF2'
Add your license here.
EOF2

cat > Makefile <<'EOF2'
.PHONY: run test lint format

run:
	./gradlew bootRun

test:
	./gradlew test

lint:
	./gradlew detekt ktlintCheck

format:
	./gradlew ktlintFormat
EOF2

cat > README.md <<EOF2
# kitchen

Kotlin + Spring Boot project using OpenCode agent workflow.

## Stack
- Kotlin
- Spring Boot
- Gradle Kotlin DSL
- Java 21

## Run
\`\`\`bash
./gradlew bootRun
\`\`\`

## Test
\`\`\`bash
./gradlew test
\`\`\`

## Base package
${BASE_PACKAGE_DOT}
EOF2

cat > PROGRESS.md <<'EOF2'
# Progress
- [x] Repository initialized
- [x] Initial documentation added
- [ ] Spring bootstrap generated
- [ ] First vertical slice implemented
EOF2

cat > settings.gradle.kts <<'EOF2'
rootProject.name = "kitchen"
EOF2

cat > build.gradle.kts <<'EOF2'
plugins {
    kotlin("jvm") version "2.2.0"
    kotlin("plugin.spring") version "2.2.0"
    id("org.springframework.boot") version "3.5.0"
    id("io.spring.dependency-management") version "1.1.7"
    id("io.gitlab.arturbosch.detekt") version "1.23.8"
    id("org.jlleitschuh.gradle.ktlint") version "13.1.0"
}

group = "com.serg"
version = "0.0.1-SNAPSHOT"

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(21))
    }
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("org.jetbrains.kotlin:kotlin-reflect")

    testImplementation("org.springframework.boot:spring-boot-starter-test")
    testImplementation("org.junit.platform:junit-platform-launcher")
}

tasks.withType<Test> {
    useJUnitPlatform()
}

kotlin {
    jvmToolchain(21)
}
EOF2

cat > detekt.yml <<'EOF2'
build:
  maxIssues: 0
EOF2

cat > compose.yml <<'EOF2'
services:
  postgres:
    image: postgres:17
    environment:
      POSTGRES_DB: kitchen
      POSTGRES_USER: kitchen
      POSTGRES_PASSWORD: kitchen
    ports:
      - "5432:5432"
EOF2

cat > Dockerfile <<'EOF2'
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
EOF2

cat > src/main/kotlin/"$BASE_PACKAGE"/kitchenApplication.kt <<EOF2
package ${BASE_PACKAGE_DOT}

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class kitchenApplication

fun main(args: Array<String>) {
    runApplication<kitchenApplication>(*args)
}
EOF2

cat > src/main/resources/application.yml <<'EOF2'
spring:
  application:
    name: kitchen
management:
  endpoints:
    web:
      exposure:
        include: health,info
EOF2

cat > src/main/resources/application-local.yml <<'EOF2'
spring:
  config:
    activate:
      on-profile: local
EOF2

cat > src/main/resources/application-test.yml <<'EOF2'
spring:
  config:
    activate:
      on-profile: test
EOF2

cat > src/main/resources/logback-spring.xml <<'EOF2'
<configuration>
  <include resource="org/springframework/boot/logging/logback/defaults.xml"/>
  <include resource="org/springframework/boot/logging/logback/console-appender.xml"/>
  <root level="INFO">
    <appender-ref ref="CONSOLE"/>
  </root>
</configuration>
EOF2

cat > src/main/resources/db/migration/V1__init.sql <<'EOF2'
-- Initial migration placeholder
EOF2

cat > src/test/kotlin/"$BASE_PACKAGE"/smoke/ApplicationSmokeTest.kt <<EOF2
package ${BASE_PACKAGE_DOT}.smoke

import org.junit.jupiter.api.Test
import org.springframework.boot.test.context.SpringBootTest

@SpringBootTest
class ApplicationSmokeTest {
    @Test
    fun contextLoads() {
    }
}
EOF2

cat > scripts/dev.sh <<'EOF2'
#!/usr/bin/env bash
set -euo pipefail
./gradlew bootRun --args='--spring.profiles.active=local'
EOF2

cat > scripts/test.sh <<'EOF2'
#!/usr/bin/env bash
set -euo pipefail
./gradlew test
EOF2

cat > scripts/release.sh <<'EOF2'
#!/usr/bin/env bash
set -euo pipefail
./gradlew clean build
EOF2

chmod +x scripts/*.sh

cat > 1.txt <<EOF2
kitchen/
├── .opencode/
│   ├── agents/
│   ├── hooks/
│   ├── rules/
│   ├── settings.json
│   └── skills/
├── docs/
│   ├── adr/
│   └── architecture/
├── .github/workflows/
├── gradle/wrapper/
├── src/main/kotlin/${BASE_PACKAGE}/
├── src/main/resources/db/migration/
├── src/test/kotlin/${BASE_PACKAGE}/
└── scripts/
EOF2

echo "Bootstrap script written to output/kitchen-bootstrap.sh"
