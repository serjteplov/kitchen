# Containers

## Kitchen Service (Spring Boot)
- Kotlin/Spring Boot application
- Serves REST API on configured port
- Stateless, horizontally scalable

## Database (PostgreSQL 17 / H2)
- Production: PostgreSQL 17 (via compose.yml)
- Development: H2 in-memory or file-based
- Schema managed via Flyway migrations

## Docker Compose
- PostgreSQL container for local development
- See compose.yml in project root
