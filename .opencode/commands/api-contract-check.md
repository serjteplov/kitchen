---
description: Validate domain model consistency and hexagonal architecture compliance
agent: build
---

Validate the kitchen project's domain model and API contract consistency:

1. **Domain model audit** — Scan `src/main/kotlin/com/serg/kitchen/domain/model/`:
   - List every entity and value object
   - Verify each has a corresponding unit test in `src/test/kotlin/com/serg/kitchen/unit/`
   - Verify each has proper validation (init blocks, non-null types)
   - Flag any entity missing tests or validation

2. **Port interface audit** — Scan `src/main/kotlin/com/serg/kitchen/application/`:
   - List all inbound (use case) and outbound (repository) port interfaces
   - Verify each inbound port has a service implementation
   - Verify each outbound port has a persistence adapter in `adapter/output/`
   - Flag orphaned ports or missing implementations

3. **Adapter wiring check** — Scan `src/main/kotlin/com/serg/kitchen/adapter/`:
   - For each REST controller in `adapter/input/rest/`: verify it depends on an application port interface, not a domain entity directly
   - For each persistence adapter in `adapter/output/`: verify it implements an outbound port interface
   - Flag any adapter that bypasses the application layer

4. **Structural violations** — Check for:
   - Domain layer importing framework classes (Spring, JPA annotations)
   - Application layer importing adapter classes
   - Shared layer containing business logic

5. **Report** — Output a structured summary:
   - Entities with/without tests and validation
   - Ports with/without implementations
   - Architecture violations with file:line references
   - Recommendations ordered by severity (critical → nice-to-have)
