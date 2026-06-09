package com.serg.kitchen.domain.model

data class Ingredient(
    val name: String,
    val quantity: Double,
    val unit: String,
) {
    init {
        require(name.isNotBlank()) { "Ingredient name must not be blank" }
        require(quantity > 0) { "Quantity must be positive" }
        require(unit.isNotBlank()) { "Unit must not be blank" }
    }
}
