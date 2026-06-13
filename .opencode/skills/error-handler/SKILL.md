---
name: error-handler
description: "Implement consistent error handling: domain exceptions, global exception handler, Problem Details (RFC 7807) responses, and validation error mapping."
---

## What I do
- Create domain exception hierarchy in `domain/exception/` (e.g., `IngredientNotFoundException`, `InvalidQuantityException`)
- Create a global `@ControllerAdvice` in `adapter/input/rest/` or `config/`
- Map domain exceptions to HTTP status codes and Problem Detail responses
- Handle validation errors from `@Valid` / Bean Validation with structured responses
- Handle Spring-level exceptions: 404, 405, 415, 500
- Ensure no stack traces or internal details leak in responses
- Log errors with appropriate severity and context

## When to use me
Use this early — error handling is cross-cutting and expensive to retrofit.

Trigger conditions:
- First endpoint is being created → set up error handling infrastructure
- New domain exception is needed → add to hierarchy, update handler
- Error responses are inconsistent → standardize with Problem Details
- Stack traces leaking in API responses
- Need to add validation error formatting

## Rules
- Exception hierarchy root: `KitchenException(message: String)` in `domain/exception/`
- Subclass for specific errors: `NotFoundException`, `ValidationException`, `ConflictException`
- Global handler class: `KitchenExceptionHandler` annotated with `@RestControllerAdvice`
- Response format: RFC 7807 Problem Details
  ```json
  {
    "type": "https://kitchen.errors/not-found",
    "title": "Resource Not Found",
    "status": 404,
    "detail": "Ingredient with id 42 not found",
    "instance": "/api/v1/ingredients/42"
  }
  ```
- Validation errors: collect field-level errors into a `"errors"` array in the Problem Detail
- Log at ERROR for 5xx, WARN for 4xx, DEBUG for validation
- Include correlation ID in log messages (once logging-tracing is set up)
- Never expose exception messages from third-party libraries in responses
- Use Spring's `ErrorResponse` or `ProblemDetail` class where available (Spring Boot 4.x)

## Self-review
Before declaring done:
- Verify all custom exceptions extend `KitchenException` (or appropriate base)
- Test with `curl` or integration test: trigger each exception type and verify response format
- Confirm no stack traces in response body for any error
- Verify 500 responses use a generic message (not the actual exception message)
- Check that validation errors include field names and messages for each invalid field
- Run `./gradlew build` — all tests must pass
- Check log output: errors logged, responses clean

## Example workflow
Setting up initial error handling:
1. Create `domain/exception/KitchenException.kt` — base exception
2. Create `domain/exception/NotFoundException.kt` — extends KitchenException
3. Create `domain/exception/ValidationException.kt` — extends KitchenException
4. Create `config/KitchenExceptionHandler.kt` — @RestControllerAdvice with @ExceptionHandler methods
5. Write integration test: `test/.../integration/ErrorHandlingTest.kt` — trigger each exception, assert response
