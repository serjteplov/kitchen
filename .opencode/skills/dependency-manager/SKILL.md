---
name: dependency-manager
description: "Manage Gradle dependencies: add, update, remove, resolve conflicts, check vulnerabilities, and maintain the version catalog."
triggers:
  - "add dependency"
  - "update dependency"
  - "upgrade version"
  - "Gradle dependency"
  - "version catalog"
  - "dependency conflict"
  - "remove dependency"
  - "build.gradle"
  - "add library"
  - "dependency tree"
---

## What I do
- Add new dependencies to `build.gradle.kts` with appropriate scope (implementation, test, runtime)
- Update dependency versions — check for breaking changes in release notes
- Remove unused dependencies — detect with `./gradlew buildHealth` or manual inspection
- Resolve version conflicts and alignment issues
- Set up and maintain Gradle version catalogs (`gradle/libs.versions.toml`)
- Check for known vulnerabilities with `./gradlew dependencyCheckAnalyze` (if plugin present)
- Analyze dependency tree: `./gradlew dependencies --configuration runtimeClasspath`
- Explain transitive dependencies and why a dependency appears in the tree

## When to use me
Use this for any Gradle dependency or build configuration change.

Trigger conditions:
- Need to add a library (e.g., MockK, WireMock, Testcontainers module)
- Spring Boot version upgrade
- Kotlin version upgrade
- Dependency conflict: `NoClassDefFoundError`, `NoSuchMethodError`, or version conflict warnings
- Unused dependency cleanup
- Setting up version catalog for the first time

Do NOT use for:
- Application properties → use `infra-setup`
- Adding Flyway migrations → use `db-migration`
- Docker/container changes → handle directly

## Rules
- Always run `./gradlew build` after any dependency change — verify no regressions
- When adding a dependency, prefer the version managed by Spring Boot's BOM — omit the version
- For non-Spring-managed deps, pin exact versions (no dynamic ranges like `1.+`)
- Check for transitive dependency conflicts with:
  ```bash
  ./gradlew dependencyInsight --configuration runtimeClasspath --dependency <group:name>
  ```
- When removing a dependency, search for imports: `rg "import com.example.lib" --include="*.kt"`
- Keep `build.gradle.kts` organized: plugins → dependencies → tasks → extra config
- Document non-obvious dependency choices with comments in `build.gradle.kts`
- Before upgrading Spring Boot, check the migration guide at spring.io
- Test dependency changes with a clean build: `./gradlew clean build`

## Self-review
Before declaring done:
- Run `./gradlew clean build` — full rebuild must succeed
- Run `./gradlew dependencies --configuration runtimeClasspath > deps.txt` and scan for:
  - Duplicate versions of the same library
  - `FAILED` or `->` conflict markers
  - Unexpected transitive dependencies
- If removing a dependency, search codebase for remaining imports: `rg "import com.example.removed" --include="*.kt"`
- Check for deprecation warnings in build output
- Verify the dependency is available from configured repositories (Maven Central, Gradle Plugin Portal)

## Example workflow
Adding MockK for unit testing:
1. Read `build.gradle.kts` — find the `dependencies` block
2. Add `testImplementation("io.mockk:mockk:1.14.0")` in the test dependencies section
3. Run `./gradlew dependencies --configuration testRuntimeClasspath | grep mockk` — verify resolution
4. Run `./gradlew build` — verify no conflicts
5. Optional: write a quick test using MockK to verify it works
