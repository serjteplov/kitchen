package com.serg.kitchen.integration

import org.junit.jupiter.api.Test
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.boot.test.web.server.LocalServerPort
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.client.RestTemplate

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class HealthEndpointTest {
    @LocalServerPort
    private var port: Int = 0

    @Test
    fun `health endpoint returns ok`() {
        val restTemplate = RestTemplate()
        val response: ResponseEntity<Map<*, *>> =
            restTemplate.getForEntity(
                "http://localhost:$port/actuator/health",
                Map::class.java,
            )

        assert(response.statusCode == HttpStatus.OK)
        assert(response.body?.get("status") == "UP")
    }
}
