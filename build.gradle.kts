plugins {
    kotlin("jvm") version "2.3.21"
    kotlin("plugin.spring") version "2.3.21"
    id("org.springframework.boot") version "4.0.6"
    id("io.gitlab.arturbosch.detekt") version "1.23.8"
    id("org.jlleitschuh.gradle.ktlint") version "13.1.0"
}

group = "com.serg"
version = "0.0.1-SNAPSHOT"

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(21))
    }
}

repositories {
	mavenCentral()
	maven { url = uri("https://repo.spring.io/snapshot") }
}

dependencies {
    // 🎯 IMPORT THE SPRING BOOT BOM PLATFORM (Crucial for Spring Boot 4)
    implementation(platform("org.springframework.boot:spring-boot-dependencies:4.1.0-SNAPSHOT"))

    // 🐋 CORE APP SERVICES (Versions are now pulled automatically via the platform block above)
    implementation("org.springframework.boot:spring-boot-starter-actuator")
    implementation("org.springframework.boot:spring-boot-starter-validation")
    implementation("org.springframework.boot:spring-boot-starter-webmvc")

    // 🧱 LANGUAGE & SERIALIZATION
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("tools.jackson.module:jackson-module-kotlin")

    // 🎛️ DEV TOOLS & DATABASE
    developmentOnly("org.springframework.boot:spring-boot-devtools")
    runtimeOnly("com.h2database:h2")

    // 🧪 TESTING ENGINE FRAMEWORK (Versions are also managed via platform)
    testImplementation("org.springframework.boot:spring-boot-starter-actuator-test")
    testImplementation("org.springframework.boot:spring-boot-starter-validation-test")
    testImplementation("org.springframework.boot:spring-boot-starter-webmvc-test")
    testImplementation("org.springframework.boot:spring-boot-testcontainers")
    testImplementation("org.jetbrains.kotlin:kotlin-test-junit5")
    testImplementation("org.testcontainers:testcontainers-junit-jupiter")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

kotlin {
	compilerOptions {
		freeCompilerArgs.addAll("-Xjsr305=strict", "-Xannotation-default-target=param-property")
	}
}

tasks.withType<Test> {
    useJUnitPlatform()
}

kotlin {
    jvmToolchain(21)
}

