package com.serg.kitchen.unit

import com.serg.kitchen.domain.model.Ingredient
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertThrows

class IngredientTest {
    @Test
    fun `should create valid ingredient`() {
        val ingredient = Ingredient(name = "Tomato", quantity = 5.0, unit = "pcs")

        assertThat(ingredient.name).isEqualTo("Tomato")
        assertThat(ingredient.quantity).isEqualTo(5.0)
        assertThat(ingredient.unit).isEqualTo("pcs")
    }

    @Test
    fun `should reject blank name`() {
        assertThrows<IllegalArgumentException> {
            Ingredient(name = "  ", quantity = 1.0, unit = "kg")
        }
    }

    @Test
    fun `should reject non-positive quantity`() {
        assertThrows<IllegalArgumentException> {
            Ingredient(name = "Salt", quantity = 0.0, unit = "g")
        }
    }
}
