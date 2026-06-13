---
name: api-integrator
description: Add REST endpoints following hexagonal architecture. Define application ports first, then implement thin REST controllers in the adapter layer.
---

## What I do
- Define inbound port interfaces in `application/port/in/`
- Implement application service logic in `application/service/`
- Create thin REST controllers in `adapter/input/rest/`
- Add integration tests for the endpoint in `test/.../integration/`

## When to use me
Use this when adding new API endpoints to the kitchen service.
Follow the hexagonal architecture: domain -> application -> adapter.

## Rules
- Controllers must be thin; business logic lives in application services
- Use constructor injection only
- Add validation annotations on request DTOs
- Test with `@SpringBootTest(webEnvironment = RANDOM_PORT)`
