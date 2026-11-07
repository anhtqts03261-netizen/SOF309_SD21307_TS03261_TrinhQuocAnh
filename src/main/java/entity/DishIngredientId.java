package entity;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class DishIngredientId implements Serializable {

    private static final long serialVersionUID = 1L;

    @Column(name = "DishID")
    private Integer dishId;

    @Column(name = "IngredientID")
    private Integer ingredientId;

    public DishIngredientId() {
    }

    public DishIngredientId(Integer dishId, Integer ingredientId) {
        this.dishId = dishId;
        this.ingredientId = ingredientId;
    }

    public Integer getDishId() {
        return dishId;
    }

    public void setDishId(Integer dishId) {
        this.dishId = dishId;
    }

    public Integer getIngredientId() {
        return ingredientId;
    }

    public void setIngredientId(Integer ingredientId) {
        this.ingredientId = ingredientId;
    }

    @Override
    public boolean equals(Object obj) {

        if (this == obj)
            return true;

        if (!(obj instanceof DishIngredientId))
            return false;

        DishIngredientId other = (DishIngredientId) obj;

        return Objects.equals(dishId, other.dishId)
                && Objects.equals(ingredientId, other.ingredientId);
    }

    @Override
    public int hashCode() {

        return Objects.hash(dishId, ingredientId);

    }

}