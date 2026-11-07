package entity;

import java.io.Serializable;

import jakarta.persistence.*;

@Entity
@Table(name = "DishIngredients")
public class DishIngredient implements Serializable {

    private static final long serialVersionUID = 1L;

    @EmbeddedId
    private DishIngredientId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("dishId")
    @JoinColumn(name = "DishID")
    private Dish dish;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("ingredientId")
    @JoinColumn(name = "IngredientID")
    private Ingredient ingredient;

    @Column(name = "RequiredQuantity")
    private Double requiredQuantity;

    public DishIngredient() {
    }

    public DishIngredientId getId() {
        return id;
    }

    public void setId(DishIngredientId id) {
        this.id = id;
    }

    public Dish getDish() {
        return dish;
    }

    public void setDish(Dish dish) {
        this.dish = dish;
    }

    public Ingredient getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient ingredient) {
        this.ingredient = ingredient;
    }

    public Double getRequiredQuantity() {
        return requiredQuantity;
    }

    public void setRequiredQuantity(Double requiredQuantity) {
        this.requiredQuantity = requiredQuantity;
    }

}