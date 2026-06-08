#!/usr/bin/env bash
set -euo pipefail
./gradlew bootRun --args='--spring.profiles.active=local'
