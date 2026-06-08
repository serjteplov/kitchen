.PHONY: run test lint format

run:
	./gradlew bootRun

test:
	./gradlew test

lint:
	./gradlew detekt ktlintCheck

format:
	./gradlew ktlintFormat
