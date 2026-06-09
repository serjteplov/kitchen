package com.serg.kitchen

import org.springframework.boot.fromApplication
import org.springframework.boot.with

fun main(args: Array<String>) {
    fromApplication<KitchenApplication>().with(TestcontainersConfiguration::class).run(*args)
}
