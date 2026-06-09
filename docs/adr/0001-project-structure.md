# ADR 0001: Project structure

## Status
Accepted

## Context
We need a project structure that supports clean separation of concerns while remaining simple enough for early-stage development.

## Decision
We use a single-module Kotlin/Spring structure with clear package boundaries following hexagonal architecture:

```
com.serg.kitchen
├── domain          # Entities, value objects, domain services
├── application     # Use case ports (in/out) and service implementations
├── adapter
│   ├── input/rest  # REST controllers
│   └── output      # Persistence, messaging, client adapters
├── config          # Spring configuration
└── shared          # Cross-cutting utilities and types
```

This keeps early development simple while preserving evolution toward modularization.

## Consequences
- Low ceremony for new features
- Package boundaries can be extracted into separate Gradle modules later if needed
- Clear dependency rules: domain has no dependencies on frameworks; application depends only on domain; adapters depend on application ports
