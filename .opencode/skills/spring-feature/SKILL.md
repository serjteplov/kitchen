---
name: spring-feature
description: "Implement a vertical slice: domain entity -> application port -> application service -> adapter controller/repository -> tests."
---

## What I do
- Create domain entities/value objects in `domain/model/`
- Define inbound port interfaces in `application/port/in/`
- Implement service logic in `application/service/`
- Create outbound port interfaces in `application/port/out/`
- Implement adapter (REST controller, JPA repository, or messaging handler)
- Add unit tests for domain logic, integration tests for adapters

## When to use me
Use this when implementing a new feature end-to-end.
Start from the domain layer and work outward.

## Rules
- Domain classes must have no Spring or framework imports
- Use constructor injection in services and adapters
- Prefer immutable data classes for domain objects
- Add validation in domain constructors (require blocks)
