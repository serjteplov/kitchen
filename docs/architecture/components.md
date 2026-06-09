# Components

## Domain layer
- Entity classes: core business objects (Ingredient, Recipe, MealPlan)
- Value objects: immutable, self-validating types (Quantity, Unit)
- Domain services: business logic spanning multiple entities

## Application layer
- Ports (interfaces): Inbound (use cases) and Outbound (repository interfaces)
- Services: orchestrate domain logic implementing inbound ports
- DTOs: request/response objects for adapter boundaries

## Adapter layer
- REST controllers: thin HTTP handlers delegating to application services
- Persistence adapters: JPA repositories implementing outbound ports
- Client adapters: HTTP/gRPC clients for external service calls
- Messaging adapters: event publishers and consumers

## Config layer
- Spring configuration classes
- Security, scheduling, and cross-cutting concern setup

## Shared layer
- Common utilities, enums, and shared types used across layers
