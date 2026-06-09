.PHONY: run test lint format

run:
	./gradlew bootRun

test:
	./gradlew test

lint:
	./gradlew ktlintCheck

format:
	./gradlew ktlintFormat
